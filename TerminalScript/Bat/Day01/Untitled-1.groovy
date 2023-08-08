// [ Groovy 全局变量定义]
// - GIT项目地址
def PRJECT = "ssh://git@gitlab.cqzk.com.cn:2222/WeiyiGeek/devopsapi.git"
def PUBKEY = "5e2f46d9-6725-4399-847f-dafb3f29d0ce"

// - 企业微信/UME - WebHookURL
// 经 - 4e1165c3-55c1-4bc4-8493-ecc5ccda9278
// 曾 - 7d7f46fa-28c6-40b3-9c45-de243ec51150 - 9206
// 程 - d9b42f56-f6e9-4dd6-867b-c288577a5503 - 9204
// 苏 - adf0d777-997d-43c4-ac58-09f15c969248 - 9203
// 傅 - 8f616eb6-7ed5-4abf-99e2-74db3fce2351 - 9209
// 马 - 12116e76958d484aa48773e7e503d4ed - 9201 
def WEBHOOK = "UME"
def UME_RECEIVER_USER = "9211"
def UME_WEBHOOK = "https://api.cqzk.com.cn/devops/v1/webhook/ume?key=8f51cb8e-9cfe-43dc-a9ae-91798150bdce"
def QY_WECHAT_WEBHOOK_KEY = "d9b42f56-f6e9-4dd6-867b-c288577a5503"
def QY_WECHAT_WEBHOOK = "https://qyapi.weixin.qq.com/cgi-bin/webhook/send?key=${QY_WECHAT_WEBHOOK_KEY}"

// - 正式环境与测试环境参数预设
def ENV_TEST() {
  def config = [:]
  config.K8S_API_SERVER = "https://slb-vip.k8s:16443"
  config.K8S_IP_SERVER = "192.168.12.110"
  config.K8S_CREDENTIALSID = "8cf24244-3e26-41a9-b7fe-3eb20778c33a"
  config.CI_NAME = "${env.JOB_NAME}"
  config.CI_NAMESPACE = "devtest"
  config.CI_ENVIRONMENT = "dev"
  config.CI_COMMAND = '["java","-jar","/app/app.jar","--spring.profiles.active=prd","--server.port=8080","--spring.redis.host=redis-single.devtest","--spring.redis.password=cqzk.com.cn","--cqzk.api.authcenter.url=10.41.40.23:30115"]'
  config.CI_STORAGE_NAME = "managed-nfs-storage"
  config.INGRESS_DOMAIN = "test.app.cqzk.com.cn"
  config.HARBOR_URL = "harbor.cqzk.com.cn/cqzk"
  config.HARBOR_AUTH = "d0ce1239-c4bf-41ed-a4c6-660ab70d9b47"
  return config
}


def ENV_PROD() {
  def config = [:]
  config.K8S_API_SERVER = "https://apiserver.cluster.cqzk:6443"
  config.K8S_IP_SERVER = "192.168.12.102"
  config.K8S_CREDENTIALSID = "k8s-cluster.cqzk-devops"
  config.CI_NAME = "${env.JOB_NAME}"
  config.CI_NAMESPACE = "devtest"
  config.CI_ENVIRONMENT = "prod"
  config.CI_COMMAND = '["java","-jar","/app/app.jar","--spring.profiles.active=prod","--server.port=8080","--logging.file.name=/logs"]'
  config.CI_STORAGE_NAME = "nfs-cqzk"
  config.INGRESS_DOMAIN = "test.app.cqzk.com.cn"
  config.HARBOR_URL = "harbor.cloud/cqzk"
  config.HARBOR_AUTH = "6186cfbc-c671-4174-a79a-a5fccbd459dd"
  return config
}

// 任务名称、任务工作空间POD名称
def JOB_NAME = "${env.JOB_NAME}-${env.BUILD_NUMBER}"
def JOB_WORKSPACE = "${env.WORKSPACE}"

// [ Groovy 全局函数定义]
// 获取真实项目路径机器构建的包信息函数
def GET_REAL_PROJECT(){
  def PROJECT = [:]
  PROJECT.path="${env.WORKSPACE}"

  PROJECT.name=sh label:'name',returnStdout: true, script: """
   echo \${JOB_NAME#*-} |tr -d '\\n'
  """
  PROJECT.version=sh label: 'version',returnStdout: true, script: """
    grep "version:" ./configs/prod.yaml | tr -d ' ' | head -n 1 | cut -d ":" -f 2 | tr -d '\\n' 
  """
  PROJECT.commitmsg=sh label: 'git_commitmsg',returnStdout: true, script: """
    git show --oneline --ignore-all-space --text | head -n 1 |tr -d '\\n'
  """
  PROJECT.commitid=sh label: 'git_commitid',returnStdout: true, script: """
    git show --oneline --ignore-all-space --text | head -n 1 | cut -d ' ' -f 1 |tr -d '\\n'
  """
  PROJECT.imagename=sh label:'imagename',returnStdout: true, script: """
   echo \${JOB_NAME#*-} |tr -d '\\n'
  """
  return PROJECT
}


// [Jenkins Pipeline 流水线 开始]
pipeline {
  // 流水线运行的主机绑定,此处利用动态的K8s节点进行。
  agent {
    kubernetes {
      cloud 'kubernetes'
      namespace 'devops'
      inheritFrom 'jenkins-slave'
      showRawYaml 'false'
      workingDir '/home/jenkins/agent'
      nodeSelector 'kubernetes.io/hostname=cqzk-226'
      // yamlFile 'KubernetesPod.yaml'
      defaultContainer 'jnlp'
      yaml """\
apiVersion:
kind: Pod
metadata:
  labels:
    app: 'jenkins-jnlp'
    job: ${JOB_NAME}
spec:
  serviceAccountName: 'jenkins-sa'
  automountServiceAccountToken: false
  securityContext:
    runAsUser: 1000   # default UID of jenkins user in agent image
  containers:
  - name: 'jnlp'
    image: 'harbor.cqzk.com.cn/devops/alpine-jenkins-jnlp:v2.330'
    imagePullPolicy: 'IfNotPresent'
    command: ["/bin/sh"]
    args: ["-c","/usr/local/bin/jenkins-agent.sh && cat"]
    tty: true
    env:
    - name: JAVA_OPTS
      value: '-Xms512m -Xmx1g -Xss1m'
    resources:
      limits: {}
      requests:
        memory: '512Mi'
        cpu: '1000m'
    volumeMounts:
    - name: 'maven-cache'
      mountPath: '/home/jenkins/.m2'
    - name: 'docker-socket'
      mountPath: '/var/run/docker.sock'
  - name: 'golang'
    image: 'harbor.cqzk.com.cn/devops/golang:1.20.4-alpine3.18'
    imagePullPolicy: 'IfNotPresent'
    command: ["/bin/sh"]
    args: ["-c","top"]
    tty: true
    env:
    - name: GO111MODULE
      value: "on"
    - name: GOPROXY
      value: "https://goproxy.cn,direct"
    - name: GOOS
      value: linux
    - name: GOARCH
      value: "amd64"
    - name: GOCACHE
      value: "/tmp/.cache/go-build"
    volumeMounts:
    - name: 'maven-cache'
      mountPath: '/tmp/.cache'
  volumes:
  - name: maven-cache
    hostPath: 
      path: /nfsdisk-31/appstorage/mavenRepo
  - name: node-modules-cache
    hostPath: 
      path: /nfsdisk-31/appstorage/node_modules
  - name: docker-socket
    hostPath: 
      path: /var/run/docker.sock
    """.stripIndent()
    }
  }
  
  // 全局选项预定义设定
  options {
    gitLabConnection('Private-Gitlab')
    gitlabBuilds(builds: ['代码拉取', '代码检测', '项目构建','镜像构建','部署测试','成品归档'])
    timeout(time: 30, unit: 'MINUTES') 
  }
  
  // 自定义环境变量, 通过 env.变量名访问 
  environment {
    // 代码仓库地址与认证地址
    GITLAB_URL = "${PRJECT}"
    GITLAB_PUB = "${PUBKEY}"

    // 代码质量检测项目名称与反馈超时时间
    SONARQUBE_PROJECTKEY = "${JOB_NAME}";
    SONARQUBE_TIMEOUT = '60';
  }

  // 自定义选择参数，在 sh 中可通过变量名访问，而在 script pipeline 脚本中通过 params.参数名称 访问 
  parameters {
    gitParameter branch: '', branchFilter: 'origin/(.*)', defaultValue: 'origin/master', description: '查看构建部署可用的Tag或Branch名称?', name: 'TagBranchName', quickFilterEnabled: false, selectedValue: 'NONE', sortMode: 'DESCENDING_SMART', tagFilter: '*', type: 'GitParameterDefinition'
    string(name: 'RELEASE_VERSION', defaultValue: "master", description: 'Message: 请选择构建部署的Tag或Branch名称?', trim: 'True')
    choice(name: 'PREJECT_ENVIRONMENT', choices: ['Prod', 'Test'], description: 'Message: 选择项目部署环境?')
	  choice(name: 'PREJECT_OPERATION', choices: ['None', 'deploy', 'rollback', 'redeploy','deployTest'], description: 'Message: 选择项目操作方式?')
    choice(name: 'IS_IMAGEBUILD', choices: ['True','False'], description: 'Message: 是否进行镜像构建操作?')
    choice(name: 'IS_RELEASE', choices: ['False','True'], description: 'Message: 是否进行编译成品发布?')
    choice(name: 'IS_SONARQUBE', choices: ['False','True'], description: 'Message: 是否进行代码质量检测?')
  }

  // 触发与Gitlab 流水线同步更新
  triggers {
    gitlab(triggerOnPush: true, triggerOnMergeRequest: true, branchFilterType: 'All')
  } 

  // 主要阶段以及子阶段流程
  stages {

    // [ 阶段1.项目代码拉取 ]
    stage ('代码拉取') {
      steps {
        // 1.构建信息输出
        echo "任务名称: ${JOB_NAME}, 项目地址: ${env.GITLAB_URL}, 构建版本: ${params.RELEASE_VERSION}, 部署环境: ${params.PREJECT_ENVIRONMENT} \n 构建操作: ${params.PREJECT_OPERATION}, 镜像构建: ${params.IS_IMAGEBUILD} , 成品发布: ${params.IS_RELEASE}, 代码质量测试: ${params.IS_SONARQUBE}"
        
        // 2.超时时间设置5分钟
        timeout(time: 5, unit: 'MINUTES') {
          script {
            try {
              checkout([$class: 'GitSCM', branches: [[name: "${params.RELEASE_VERSION}"]], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[credentialsId: "${env.GITLAB_PUB}", url: "${env.GITLAB_URL}"]]])
              updateGitlabCommitStatus name: '代码拉取', state: 'success'
            } catch(Exception err) {
              updateGitlabCommitStatus name: '代码拉取', state: 'failed'
              // * 显示错误信息但还是会进行下一阶段操作
              echo err.toString()    /* hudson.AbortException: Couldn't find any revision to build. Verify the repository and branch configuration for this job. */
              unstable '拉取代码失败'
              error "[-Error] : 代码拉取失败\n [-Msg] : ${err.getMessage()} " /* 失败立即停止 */
            } 
            // 4.查看可用的Tag版本 (注意必须包含在script{}中),项目需要打Tag此处按需求开启。
            // def TAG_RELEASE=sh label: 'release',returnStdout: true, script: """\
            // git tag -l --column | tr -d ' ' > release.tag ;
            // export a="\$(sed "s#v#, v#g" release.tag)";
            // echo [\${a#,*}]
            // """

            // 5.拉取代码后再切换到指定版本
            // sh label: 'checkout_version',returnStatus: true  ,script: '[ -n "${RELEASE_VERSION}" ] &&  git checkout ${RELEASE_VERSION} || { echo -e "切换至指定的tag的版本 tag：${RELEASE_VERSION} 不存在或为空，请检查输入的tag!" && exit 1; }'

            // 6.利用GET_REAL_PROJECT函数获取JAVA项目真实的构建空间路径以及获取pom.xml项目文件信息
            project = GET_REAL_PROJECT()

            // 7.验证部署环境进行预设环境参数值
            if ( "${params.PREJECT_ENVIRONMENT}" == "Prod" ) {
              config = ENV_PROD()
              print "${params.PREJECT_ENVIRONMENT}"
            } else {
              config = ENV_TEST()
              print "${params.PREJECT_ENVIRONMENT}"
            }

            // 8.通过企业微信进行构建通知
            echo  "项目真实路径: ${project.path} \n项目信息: ${project.name} ${project.version} \nCommit信息:${project.commitmsg} \n镜像仓库与名称:${config.HARBOR_URL}/${project.imagename}"
            if ( "${WEBHOOK}" == "UME" ) {
              sh """\
              curl -m 15 ${UME_WEBHOOK} \
              -H 'Content-Type: application/json' \
              -d '{
                  "uid": "${UME_RECEIVER_USER}",
                  "type": "cardtext",
                  "title": "【应用构建】应用构建开始通知",
                  "color": "blue",
                  "content":"任务名称:【${JOB_NAME}】任务\\n项目信息: ${project.name}-${project.version}\\n提交信息: ${project.commitmsg}\\n构建版本: ${params.RELEASE_VERSION} - ${params.TagBranchName}\\n构建操作: ${params.PREJECT_OPERATION}\\n镜像构建: ${params.IS_IMAGEBUILD}\\n部署环境: ${params.PREJECT_ENVIRONMENT}\\n成品归档: ${params.IS_RELEASE}\\n质量测试: ${params.IS_SONARQUBE}\\n镜像仓库: ${config.HARBOR_URL}/${project.imagename}:${params.PREJECT_ENVIRONMENT}\\n镜像仓库: ${config.HARBOR_URL}/${project.imagename}:${project.version}-${params.PREJECT_ENVIRONMENT}\\n[查看当前任务流水线](${env.BUILD_URL})",
                  "url": "${env.BUILD_URL}",
                  "userid": "2b4ef4d04d6d432986de1b671d2f9355",
                  "username": "经伟"
                }'
              """
            } else {
              sh """\
              curl ${QY_WECHAT_WEBHOOK} \
              -H 'Content-Type: application/json' \
              -d '{
                  "msgtype": "markdown",
                  "markdown": {
                    "content":"Jenkins-消息通知<font color=\\"info\\">【${JOB_NAME}】</font>任务开始 \\n
                    >项目信息: <font color=\\"warning\\">${project.name}-${project.version}</font>
                    >提交信息: <font color=\\"warning\\">${project.commitmsg}</font>
                    >构建版本: ${params.RELEASE_VERSION} - ${params.TagBranchName}
                    >构建操作: ${params.PREJECT_OPERATION}
                    >镜像构建: ${params.IS_IMAGEBUILD}
                    >部署环境: ${params.PREJECT_ENVIRONMENT}
                    >成品归档: ${params.IS_RELEASE}
                    >质量测试: ${params.IS_SONARQUBE}
                    >镜像仓库: ${config.HARBOR_URL}/${project.imagename}:${params.PREJECT_ENVIRONMENT}
                    >镜像仓库: ${config.HARBOR_URL}/${project.imagename}:${project.version}-${params.PREJECT_ENVIRONMENT}
                    >[查看当前任务流水线](${env.BUILD_URL})
                    ><@经伟>"
                  }
              }'
              """
            }
          }
        }
     }
   }

    stage ('代码检测') {
      // (1) 判断是否进行代码质量检测
      when {
        expression { return params.PREJECT_OPERATION != "rollback" }
        // 一 真 全 真
        anyOf {
          environment name: 'IS_SONARQUBE', value: 'True'
          //environment name: 'PREJECT_OPERATION', value: 'deploy'
        }
      }
      steps {
        script {
        // (2) Tool 后的名称一定是对应全局工具配置中sonar扫描器的名字进行代码质量检测
        def sonarqubeScanner = tool 'Sonar-Scanner';
        withSonarQubeEnv(credentialsId: '18d24c8f-9772-4b3e-934c-f80ed0e96cde') {
          // 注意:可以将sonarQube的属性定义在这里，也可以定义在项目文件中然后在这里引用配置文件
          sh "${sonarqubeScanner}/bin/sonar-scanner " + 
                "-Dsonar.projectName=${JOB_NAME} " + 
                "-Dsonar.projectKey=${SONARQUBE_PROJECTKEY} " + 
                "-Dsonar.projectVersion=${RELEASE_VERSION} " + 
                "-Dsonar.sourceEncoding=utf8  " + 
                "-Dsonar.sources=.  " + 
                "-Dsonar.language=java  " + 
                "-Dsonar.java.binaries=."
        }
        // (3) 暂停10s等待sonarqube扫描反馈
        sleep time: "${env.SONARQUBE_TIMEOUT}", unit: 'NANOSECONDS'
        sh "sleep ${SONARQUBE_TIMEOUT}"
        // 方式1
        // timeout(1) {
        //     def qg = waitForQualityGate() 
        //     if (qg.status != 'OK') {
        //         error "未通过Sonarqube的代码质量阈检查，请及时修改！failure: ${qg.status}"
        //     } else {
        //         echo "successful"
        //     }
        // } 
        try {
        // 方式2
          timeout(time: 1, unit: 'MINUTES') {
            waitForQualityGate abortPipeline: true
          }
          updateGitlabCommitStatus name: '代码检测', state: 'success'
        } catch(Exception err) {
          updateGitlabCommitStatus name: '代码检测', state: 'failed'
          // 显示错误信息但还是会进行下一阶段操作
          unstable '代码检测失败'
        }
        }
      }
    }
    

    stage ("项目构建") {
      // (1) 判断项目是否已构建打包或者是回滚,如果是回滚则无需构建。
      when {
        expression { return params.PREJECT_OPERATION != "rollback" && params.PREJECT_OPERATION != "redeploy" && params.PREJECT_OPERATION != "deployTest" }
      }
      steps {
        // (2) 打包验证
        // 注意 从 0.5 版开始，阶段中的 container 必须位于“steps”块中。
        container('golang') {
        script {
          try {
            sh script: """
            go mod download && go mod verify \
            && go build -v -o devopsapi
            """
            updateGitlabCommitStatus name: '项目构建', state: 'success'
          } catch(Exception err) {
            echo err.toString()    /* hudson.AbortException: Couldn't find any revision to build. Verify the repository and branch configuration for this job. */
            unstable '项目构建失败'
            updateGitlabCommitStatus name: '项目构建', state: 'failed'
            error "[-Error] : 项目构建失败\n [-Msg] : ${err.getMessage()} " /* 构建停止 */
          }
        }
       }
      }
    }

 
    stage ("镜像构建") {
      when {
        expression { return params.PREJECT_OPERATION != "rollback" && params.PREJECT_OPERATION != "redeploy"}
        anyOf {
          environment name: 'IS_IMAGEBUILD', value: 'True'
        }
      }
      steps {
        script {
            // harbor 仓库认证
            withCredentials([usernamePassword(credentialsId: "${config.HARBOR_AUTH}", passwordVariable: 'HARBOR_PWD', usernameVariable: 'HARBOR_USR')]) {
              sh """
                sudo docker login -u ${HARBOR_USR} -p ${HARBOR_PWD} ${config.HARBOR_URL}
              """
            }
            // 拉取镜像构建Dockerfile
            withCredentials([string(credentialsId: '55980ac0-043b-48ac-a36c-1c95a28fb902', variable: 'devops_api_token')]) {
              sh script: """
                cd ${project.path} \
                &&  curl -s --header "PRIVATE-TOKEN: ${devops_api_token}" "http://gitlab.cqzk.com.cn/api/v4/projects/75/repository/files/Jenkins%2fbuild%2fdevopsapi.Dockerfile/raw?ref=master" -o Dockerfile 
              """
            }
            try {
              def appname = "${project.artifactId}-${project.version}"
              sh """
              cd ${project.path} \
              && sed -i "s#{{APPNAME}}#${appname}#g" Dockerfile \
              && sudo docker build -t ${config.HARBOR_URL}/${project.imagename}:${params.PREJECT_ENVIRONMENT} -t ${config.HARBOR_URL}/${project.imagename}:${project.version}-${params.PREJECT_ENVIRONMENT} . \
              && sudo docker push ${config.HARBOR_URL}/${project.imagename}:${params.PREJECT_ENVIRONMENT} \
              && sudo docker push ${config.HARBOR_URL}/${project.imagename}:${project.version}-${params.PREJECT_ENVIRONMENT}
              """
              updateGitlabCommitStatus name: '镜像构建', state: 'success'
            }catch(Exception err) {
              echo err.toString()    /* hudson.AbortException: Couldn't find any revision to build. Verify the repository and branch configuration for this job. */
              unstable '镜像构建失败'
              updateGitlabCommitStatus name: '镜像构建', state: 'failed'
              error "[-Error] : 镜像构建失败\n [-Msg] : ${err.getMessage()} "  /* 构建停止 */
            }
        }
      }
    }

    
    stage ("测试部署") {
      when {
        expression { return params.PREJECT_OPERATION == "deploy" && params.PREJECT_ENVIRONMENT != "Prod" }
      }
      steps {
        script {
            try {
              // 资源清单拉取
              withCredentials([string(credentialsId: '55980ac0-043b-48ac-a36c-1c95a28fb902', variable: 'devops_api_token')]) {
                sh script: """
                cd ${project.path} \
                &&  curl -s --header "PRIVATE-TOKEN: ${devops_api_token}" "http://gitlab.cqzk.com.cn/api/v4/projects/75/repository/files/Jenkins%2fdeploy%2fservice.yml/raw?ref=master" -o service.yml \
                &&  curl -s --header "PRIVATE-TOKEN: ${devops_api_token}" "http://gitlab.cqzk.com.cn/api/v4/projects/75/repository/files/Jenkins%2fdeploy%2fstatefulset.yml/raw?ref=master" -o statefulset.yml
                """
              }

              // 部署资源清单替换
              sh label: 'deploy', script: """
                cd ${project.path} \
                && sed -i -e "s#__APPNAME__#${config.CI_NAME}#g" service.yml statefulset.yml \
                && sed -i -e "s#__ENVIRONMENT_SLUG__#${config.CI_ENVIRONMENT}#g" service.yml statefulset.yml \
                && sed -i -e "s#__NAMESPACE__#${config.CI_NAMESPACE}#g" service.yml statefulset.yml \
                && sed -i -e "s#__VERSION__#${project.version}#g" statefulset.yml \
                && sed -i -e "s#__IMAGE_NAME__#${config.HARBOR_URL}/${project.imagename}#g" statefulset.yml \
                && sed -i -e "s#__TAG_VERSION__#latest#g" statefulset.yml \
                && sed -i -e "s#__COMMAND__#${config.CI_COMMAND}#g" statefulset.yml \
                && sed -i -e "s#__STORAGE_NAME__#${config.CI_STORAGE_NAME}#g" statefulset.yml \
                && cat service.yml \
                && cat statefulset.yml
              """

              // 使用K8S集群票据进行操作远程集群部署资源
              withKubeConfig(caCertificate: '', clusterName: '', contextName: '', credentialsId: "${config.K8S_CREDENTIALSID}", namespace: '', serverUrl: "${config.K8S_API_SERVER}") {
                String[] K8S_API_DOMAIN;
                K8S_API_DOMAIN = "${config.K8S_API_SERVER}".split('//');
                K8S_API_DOMAIN = "${K8S_API_DOMAIN[1]}".split(':');
                print "K8S_API_DOMAIN ->" + K8S_API_DOMAIN[0];

                // 资源状态查看验证是否首次执行
                res_status=sh label:'status',returnStdout: true, script: """ 
                  echo "${config.K8S_IP_SERVER} ${K8S_API_DOMAIN[0]}" | sudo tee -a /etc/hosts  >> /dev/null \
                  && kubectl get pod -n ${config.CI_NAMESPACE} | grep "${config.CI_NAME}-${config.CI_ENVIRONMENT}" | wc -l | head -n 1 |tr -d '\\n'
                """
                print res_status

                // 如果为0则代表无该资源进行部署
                if ( "${res_status}" == "0" ) {
                  print "first - ${res_status}"
                  sh label:'first', script: """
                    kubectl apply -f statefulset.yml \
                    && kubectl apply -f service.yml \
                    && kubectl wait pod -n ${config.CI_NAMESPACE} --for=condition=Ready --selector=app=${config.CI_NAME} --timeout=120s \
                    && kubectl get pod,svc -n ${config.CI_NAMESPACE} -l app=${config.CI_NAME} -o wide \
                    && kubectl create ingress test-app -n ${config.CI_NAMESPACE} --class=ingress-nginx --rule="${config.INGRESS_DOMAIN}/${project.imagename}(/|\$)(.*)=${config.CI_NAME}-${config.CI_ENVIRONMENT}:8080" --annotation nginx.ingress.kubernetes.io/rewrite-target=/\$2
                  """
                } else {
                  print "notfirst - ${res_status}"
                  sh label:'notfirst', script: """
                    kubectl apply -f statefulset.yml \
                    && kubectl apply -f service.yml \
                    && kubectl delete pod -n ${config.CI_NAMESPACE} -l app=${config.CI_NAME} \
                    && kubectl wait pod -n ${config.CI_NAMESPACE} --for=condition=Ready --selector=app=${config.CI_NAME} --timeout=120s \
                    && kubectl get pod,svc -n ${config.CI_NAMESPACE} -l app=${config.CI_NAME} -o wide \
                    && kubectl get ingress -n ${config.CI_NAMESPACE}
                  """
                }

                // 资源健康检查，此处需要注意`\`转义
                replicas=sh label:'replicas',returnStdout: true, script: """
                  kubectl get sts -n ${config.CI_NAMESPACE} ${config.CI_NAME}-${config.CI_ENVIRONMENT} --template "{{.status.replicas}}" | head -n 1 |tr -d '\\n'
                """
                readyReplicas=sh label:'readyReplicas',returnStdout: true, script: """
                  kubectl get sts -n ${config.CI_NAMESPACE} ${config.CI_NAME}-${config.CI_ENVIRONMENT} --template "{{.status.readyReplicas}}" | head -n 1 |tr -d '\\n'
                """
                if ("${replicas}" == "${readyReplicas}") {
                  sh """
                    curl -s ${QY_WECHAT_WEBHOOK} \
                    -H 'Content-Type: application/json' \
                    -d '{
                        "msgtype": "markdown",
                        "markdown": {
                          "content":"Jenkins-消息通知<font color=\\"info\\">【${JOB_NAME}】</font>在${config.CI_ENVIRONMENT}环境中部署成功!^_^\\n
                          >访问地址: <font color=\\"warning\\">[${config.INGRESS_DOMAIN}/${project.imagename}](${config.INGRESS_DOMAIN}/${project.imagename})</font>
                          >[查看当前任务流水线](${env.BUILD_URL})"
                        }
                    }'
                  """
                } else {
                  sh """
                    kubectl logs -n devtest --max-log-requests=5 -l app=${config.CI_NAME} --since=5m \
                    && curl -s ${QY_WECHAT_WEBHOOK} \
                    -H 'Content-Type: application/json' \
                    -d '{
                        "msgtype": "markdown",
                        "markdown": {
                          "content":"Jenkins-消息通知<font color=\\"info\\">【${JOB_NAME}】</font>在${config.CI_ENVIRONMENT}环境中部署失败!:(\\n
                          ><font color=\\"warning\\">[请,点击当前任务流水线查看错误信息!](${env.BUILD_URL})</font>"
                        }
                    }'
                  """
                } 
              }

              updateGitlabCommitStatus name: '测试部署', state: 'success'
            }catch(Exception err) {
              echo err.toString()    /* hudson.AbortException: Couldn't find any revision to build. Verify the repository and branch configuration for this job. */
              unstable '部署失败'
              updateGitlabCommitStatus name: '测试部署', state: 'failed'

              // 构建停止
              error "[-Error] : 测试部署失败\n [-Msg] : ${err.getMessage()} "
            }
        }
      }
    }
    
    stage('成品归档') {
      when {
        expression { return params.PREJECT_OPERATION != "rollback" && params.PREJECT_OPERATION != "redeploy"}
        anyOf {
          environment name: 'IS_RELEASE', value: 'True'
        }
      }
      steps {
        script {
          try {
              archiveArtifacts artifacts: "**/*.jar", onlyIfSuccessful: true
              updateGitlabCommitStatus name: '成品归档', state: 'success'
          } catch (Exception err) {
              updateGitlabCommitStatus name: '成品归档', state: 'failed'
              echo err.toString()    /* hudson.AbortException: Couldn't find any revision to build. Verify the repository and branch configuration for this job. */
          }
        }
      }
    }
  }

  // (12) POST阶段当所有任务执行后触发进行工作空间的清理以及消息通知;
  post {
    always {
      /* clean up our workspace */
      deleteDir() 
    }
    unstable {
      echo "Pipeline ${env.JOB_NAME} 项目不稳定 :/"
    }
    success {
      echo "Pipeline ${env.JOB_NAME} 项目成功 ^_^ "
      script {
       sh """\
        curl -m 15 ${UME_WEBHOOK} \
        -H 'Content-Type: application/json' \
        -d '{
            "uid": "${UME_RECEIVER_USER}",
            "type": "cardtext",
            "title": "【应用构建】应用构建成功通知 ^_^",
            "color": "green",
            "content":"任务名称:【${JOB_NAME}】\\n项目信息: ${project.name}-${project.version}\\n构建用时: ${currentBuild.durationString}\\n[查看当前任务流水线](${env.BUILD_URL})",
            "url": "${env.BUILD_URL}",
            "userid": "2b4ef4d04d6d432986de1b671d2f9355",
            "username": "经伟"
          }'
        """
      }
    }
    failure {
      echo "Pipeline ${env.JOB_NAME} 项目失败 :("
      script {
        sh """\
        curl -m 15 ${UME_WEBHOOK} \
        -H 'Content-Type: application/json' \
        -d '{
            "uid": "${UME_RECEIVER_USER}",
            "type": "cardtext",
            "title": "【应用构建】应用构建识失败通知 :(",
            "color": "red",
            "content":"任务名称:【${JOB_NAME}】\\n项目信息: ${project.name}-${project.version}\\n构建用时: ${currentBuild.durationString}\\n[查看当前任务流水线](${env.BUILD_URL})",
            "url": "${env.BUILD_URL}",
            "userid": "2b4ef4d04d6d432986de1b671d2f9355",
            "username": "经伟"
          }'
        """
      }
    }
    changed {
      echo "Pipeline ${env.JOB_NAME} 项目改变 .-."
    }
  }
}