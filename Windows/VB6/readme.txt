docker-compose build

this will give you liveforensics/buildbox:vb6-temp

extract vb6.zip into D:\user-volumes\VB6\ or wherever is suitable (change the volume mapping below if you use a different place)

run it up like this

docker run -it --name vb6 -v D:\user-volumes\VB6\:c:\vb6 liveforensics/buildbox:vb6-temp powershell

now you're in the container run vb6setup.ps1

this will install vb6
cd into project and test that VB will run

VB6.EXE /m .\Project1.vbp /out c:\vb6\build.log

make sure you remember to commit the image 

docker commit vb6 liveforensics/buildbox:vb6

now you can run up the working container

docker run -it --rm --name vb6 -v D:\user-volumes\VB6\:c:\vb6 liveforensics/buildbox:vb6 powershell

or directly..

docker run -it --rm --name vb6 -v D:\user-volumes\VB6\:c:\vb6 liveforensics/buildbox:vb6 vb6.exe /m c:\vb6\project\project1.vbp /out c:\vb6\build.log