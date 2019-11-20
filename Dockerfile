FROM ubuntu:16.04
LABEL maintainer "NVIDIA CORPORATION <cudatools@nvidia.com>"
RUN sed -i "s/archive.ubuntu./mirrors.aliyun./g" /etc/apt/sources.list
RUN sed -i "s/deb.debian.org/mirrors.aliyun.com/g" /etc/apt/sources.list
RUN sed -i "s/security.debian.org/mirrors.aliyun.com\/debian-security/g" /etc/apt/sources.list
RUN sed -i 's/archive.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list
RUN apt-get update
RUN  apt-get install -y nginx
ADD ./default /etc/nginx/sites-available
RUN apt-get update
RUN  apt-get upgrade -y
RUN  apt-get install -y libglib2.0-0
RUN  apt-get install -y libsm6
RUN  apt-get install -y libxrender1
RUN  apt-get install -y libxext-dev
RUN  apt-get install -y scrot
RUN  apt-get install -y python3
RUN apt-get install -y wget vim
RUN wget -O /tmp/get-pip.py https://bootstrap.pypa.io/get-pip.py
RUN python3 /tmp/get-pip.py
RUN pip3 install --upgrade pip
ADD ./Shanghai /etc/
RUN mv /etc/Shanghai /etc/localtime
RUN echo 'Asia/Shanghai' >/etc/timezone
ADD ./requirements.txt /tmp/requirements.txt
RUN pip3 install --default-timeout=1000  -i https://pypi.tuna.tsinghua.edu.cn/simple  -r /tmp/requirements.txt
ADD ./Traffic_Project /opt/Traffic_Project
WORKDIR /opt/Traffic_Project/
EXPOSE 8080
CMD nohup sh -c '/usr/sbin/nginx && python3 Monitor.py'
