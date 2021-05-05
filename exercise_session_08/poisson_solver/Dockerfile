FROM ubuntu:trusty
RUN mkdir poisson_solver
COPY . /poisson_solver
WORKDIR /poisson_solver/
RUN sudo apt-get update && sudo apt-get install make -y
RUN sudo apt-get install g++ -y
RUN make clean && make
CMD ./main
