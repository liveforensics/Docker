# PHASE 1

do a docker-compose build 
to get the liveforensics/buildbox:sdk7.1-base image

then 

docker run -it --name sdk71 -v c:\temp\dockerfolder:c:\sdk liveforensics/buildbox:sdk7.1-base powershell

where i've previously extracted the sdk 7.1 iso folders into c:\temp\dockerfolder

inside the running container, go to c:\persist and run

.\permissions.ps1

this will set the registry keys for an older version of the dotnet framework, which fools the sdk installer into working!

then change to c:\sdk\sdk\setup - or whereever you've mapped the sdk setup folder and run

 .\SDKSetup.exe /quiet /norestart

 give it a good few minutes to complete.

 Now you should have sdk 7.1 installed. Go back into c:\persist and run

 .\andback.ps1

 to reset the registry keys to the current version of the dotnet framework.

if you want to make the image a bit smaller, go into C:\Program Files\Microsoft SDKs\Windows\v7.1 and run

remove-item -Recurse -Force .\Samples\

now exit the container and commit it as an image file like this

docker commit sdk71 liveforensics/buildbox:sdk7.1

# PHASE 2

now we're going to add the jenkins stuff

docker-compose -f docker-compose-2.yml build

this creates the liveforensics/buildbox:sdk7.1-jenkins image

