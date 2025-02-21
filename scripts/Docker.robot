*** Settings ***
Library    OperatingSystem
Library    Process
Library    String
Library    pause_until_enter.py
*** Test Cases ***

1 Test Case CGMN-____: To Verify the Installation of Docker Packages
    [Documentation]    Verifying if Docker-related packages are installed on the ECU.
    Run Process    dpkg -l | grep docker    shell=True    stdout=stdout.txt
    ${output}=    Get File    stdout.txt
    Should Contain    ${output}    docker
    Should Contain    ${output}    docker-ce
    Should Contain    ${output}    python3-docker-compose
    Log    Observed that the Docker packages are installed.

2 Test Case CGMN-____: To Verify Pulling the "hello-world" Image from Docker Hub
    [Documentation]    Verifying the default pulling of the "hello-world" image from Docker Hub.
    Run Process    docker pull hello-world    shell=True    stdout=stdout.txt
    ${output}=    Get File    stdout.txt
    Should Contain    ${output}    Pulling from library/hello-world
    Run Process    docker images    shell=True    stdout=stdout.txt
    ${output}=    Get File    stdout.txt
    Should Contain    ${output}    hello-world
    Log    Observed that Docker successfully pulled the "hello-world" image from Docker Hub.

3 Test Case CGMN-____: To Verify Running the "hello-world" Image from Docker Hub
    [Documentation]    Verifying Docker is able to run the "hello-world" image from Docker Hub.
    Run Process    docker pull hello-world    shell=True    stdout=stdout.txt
    Run Process    docker images    shell=True    stdout=stdout.txt
    Run Process    docker run hello-world    shell=True    stdout=stdout.txt
    ${output}=    Get File    stdout.txt
    Should Contain    ${output}    Hello from Docker!
    Log    Observed that the Docker "hello-world" image ran successfully.

4 Test Case CGMN-____: To Verify Pulling "hello-world" Image Without Network
    [Documentation]    Verifying that pulling the "hello-world" image fails when the Ethernet connection is disconnected.
    Log To Console    \nDisconnect the Ethernet connection and press Enter.
    Pause Until Enter
    Run Process    docker pull hello-world    shell=True    stdout=stdout.txt
    ${output}=    Get File    stdout.txt
    Should Not Contain    ${output}    Pulling from library/hello-world
    Log To Console    \nConnect the Ethernet connection and press Enter.
    Pause Until Enter
    Log    Observed the error message related to network connectivity and hello-world image not pulled from the docker hub.

5 Test Case CGMN-____: To verify the pushing container image from ECU to Docker Hub
    [Documentation]    Verifying the ECU image upload process to Docker Hub.
    Run Process    docker push mv238/hello-world/hello-world:latest    shell=True    stdout=stdout.txt
    Run Process    docker images    shell=True    stdout=stdout.txt
    ${output}=    Get File    stdout.txt
    Should Contain    ${output}    mv238/hello-world/hello-world
    Log    Observed that the container image is successfully uploaded from the ECU to Docker Hub, confirming the image is available in the Docker Hub repository.
