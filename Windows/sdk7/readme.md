## PHASE 1

start with a..

* docker-compose -f .\docker-compose-1909-1.yml build
* docker-compose -f .\docker-compose-2004-1.yml build

to get the **liveforensics/buildbox:xxxx-sdk7.1-intermediate** image

then 

* docker run -it --name sdk71 -v c:\temp\dockerfolder:c:\sdk liveforensics/buildbox:1909-sdk7.1-intermediate powershell
* docker run -it --name sdk71 -v c:\temp\dockerfolder:c:\sdk liveforensics/buildbox:2004-sdk7.1-intermediate powershell

where i've previously extracted the sdk 7.1 iso folders into c:\temp\dockerfolder

inside the running container..
```
C:\persist\takeownership.ps1
```
this will set the registry keys for an older version of the dotnet framework, which fools the sdk installer into working!

change this to whereever you've mapped the sdk setup folder and run..

```
cd C:\sdk\sdk\Setup\
.\SDKSetup.exe /quiet /norestart
```

give it a good few minutes to complete.

Now you should have sdk 7.1 installed. Go back into c:\persist and run..

```
C:\persist\andback.ps1
```

to reset the registry keys to the current version of the dotnet framework.

if you want to make the image a bit smaller..

```
Remove-Item -Recurse -Force 'C:\Program Files\Microsoft SDKs\Windows\v7.1\Samples\'
```

now exit the container and commit it as an image file like this

* docker commit sdk71 liveforensics/buildbox:1909-sdk7.1-base
* docker commit sdk71 liveforensics/buildbox:2004-sdk7.1-base

delete the container

```
docker rm sdk71
```

## PHASE 2
now we're going to make a runnable container

* docker-compose -f .\docker-compose-1909-2.yml build
* docker-compose -f .\docker-compose-2004-2.yml build


which will give you **liveforensics/buildbox:xxxx-sdk7.1**

you can run the image as a standalone build container like this..

* docker run -it --rm --name sdk71 liveforensics/buildbox:1909-sdk7.1
* docker run -it --rm --name sdk71 liveforensics/buildbox:2004-sdk7.1

inside the container run setenv.cmd /? to see the options


## PHASE 3

now we're going to add the jenkins stuff

* docker-compose -f docker-compose-1909-3.yml build
* docker-compose -f docker-compose-2004-3.yml build


this creates the **liveforensics/buildbox:xxxx-sdk7.1-jenkins** image

* docker rmi liveforensics/buildbox:1909-sdk7.1-base liveforensics/buildbox:1909-sdk7.1-intermediate
* docker rmi liveforensics/buildbox:2004-sdk7.1-base liveforensics/buildbox:2004-sdk7.1-intermediate
