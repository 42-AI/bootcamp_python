FROM blang/latex:ubuntu

RUN pwd

COPY . /data/bootcamp_python

WORKDIR /data/bootcamp_python

RUN pwd\
	&& make \
	&& ls -l . \
	&& ls -l module00/subject


