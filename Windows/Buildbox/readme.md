## PHASE 1

let's start by building all the individual versions 1803,1809,1903,1909,2004
each image has visual studio installed

* docker-compose -f .\stage1-compose.yml build

this will create **liveforensics/buildbox:xxxx** images

these containers can be run standalone like this

* docker run -it --rm liveforensics/buildbox:1909

## PHASE 2

now we'll add the jenkins magic

* docker-compose -f .\stage2-compose.yml build

this will create **liveforensics/buildbox:xxxx-jenkins** images

