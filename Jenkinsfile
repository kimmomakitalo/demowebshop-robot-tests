// Jenkins pipeline for the Demo Web Shop smoke tests.
// Assumes a Windows agent with Python on PATH (and `rfbrowser init chromium` run once).

pipeline {
    agent any

    options {
        timeout(time: 15, unit: 'MINUTES')
        buildDiscarder(logRotator(numToKeepStr: '20'))
    }

    triggers {
        // Check GitHub for new commits every ~5 minutes and run the tests if there are any.
        // (Polling, because GitHub webhooks cannot reach a Jenkins running on localhost.)
        pollSCM('H/5 * * * *')
    }

    parameters {
        string(name: 'INCLUDE_TAG', defaultValue: 'smoke', description: 'Run only tests with this tag')
    }

    environment {
        // Robot crashes with the system-wide PYTHONIOENCODING=utf-8:surrogateescape.
        PYTHONIOENCODING = 'utf-8'
    }

    stages {
        stage('Install dependencies') {
            steps {
                bat 'python -m pip install -r requirements.txt'
            }
        }

        stage('Run tests') {
            steps {
                // Failing tests must not abort the pipeline: the Robot plugin below
                // sets the build result from the pass rate instead.
                bat(returnStatus: true, script: """
                    robot --outputdir results ^
                          --variable HEADLESS:True ^
                          --include ${params.INCLUDE_TAG} ^
                          tests
                """)
            }
        }
    }

    post {
        always {
            robot(
                outputPath: 'results',
                passThreshold: 100.0,
                unstableThreshold: 80.0,
                otherFiles: 'browser/screenshot/*.png'
            )
        }
    }
}
