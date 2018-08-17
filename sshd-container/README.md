## Assurity Take Home Assignment

I implemented the assignment using docker containers.

## Steps to run the container

#### Build the container

`./automation/build.sh`

* By default, the container will expose only the ports we ask for and by exposing 22, we have closed everything else.

* Only root login is made possible and by disabling password based login, we have forced the usage of public-private keys.

* Along with building the container, the script also gives you a private key. Please copy it to some file.
  
  * This is done to mimic actual production case where you create the private key only once and give it.
  
  * The script deletes the private key and the end user is responsible for saving it.
  
  * I copied it to `/tmp/mykey.key` and set it to `600` permissions.

* The docker container built is versioned by the github SHA thereby making the process of going back easier. In this case, the container is built very quickly and this step is needless but in bigger containers, this is useful.


#### Run the container

`./automation/run.sh`

* The script takes in some cmd line arguments and adapts the program accordingly (there might some corner cases I might have missed out). Running `run.sh` with no cmd line arguments is good enough.
  
  * The script starts the container by mapping port `22` on the container to `22222` on the host
  
  * The script mounts the directory containing the public key so that the container itself doesn't have the keys (making it much more secure.)

#### Start an ssh session

`ssh -i <private-key-location> root@localhost -p 22222`

You will be greeted by the MOTD and be dropped to the shell
