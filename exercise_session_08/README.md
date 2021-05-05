EX1:
I did everything as told. No problems. Ubuntu works fine on my new powerful vm (at least compared with my laptop).
I was able to compile and run the poisson code.
I installed all the dependecies to visualize the code with python. The plot is in the output folder.
Created snapshot.
I tried to install open MPI on my laptop but it didn't worked.	

EX2:
Everything worked fine local and on the vm. The command to mount the output folder from the container in my vm is:
'docker run -v "$(pwd)"/output_container:poisson_solver/output massstab/poisson:latest'
The Dockerfile is in the poisson_solver folder.
I had already a docker hub account. I have a nice little telegram bot on my raspberry-pi running in a docker container. You can find him by searching in telegram @trooublebot. He can tell youo whats the irchel mensa menu today :)

I pulled the docker images on my vm an run it. It worked.





