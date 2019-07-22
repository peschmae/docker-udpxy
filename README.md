# udpxy Docker image
Even though I found quite a few docker images for udpxy, none of them properly 
leveraged the mutli-stage builds.  

Since there are no udpxy packages most end up installing make and gcc which 
bloats the image.  

I'm using a `debian:buster` image to build the udpxy binary and then copy it 
to the second stage which is a `debian:buster-slim`.  

This way I end up with an image that's around 70mb.  
I might switch to alpine to decrease the size even more at some point.
