FROM jarvice/ubuntu-ibm-mldl-ppc64le

#add Jupyter
RUN pip install --upgrade pip
RUN pip install notebook pyyaml
RUN pip install jupyter
RUN pip install ijson
RUN pip install pandas

RUN pip install pandas_datareader
RUN pip install httplib2
RUN apt-get install -y build-essential
RUN apt-get install -y libssl-dev
RUN apt-get install -y libffi-dev
RUN apt-get install -y python-dev
RUN apt-get install -y python-matplotlib
RUN apt-get install -y python-lxml
RUN apt-get install -y openssh-server
RUN pip install cython
RUN apt-get install -y python-scipy
RUN pip install scikit-learn
RUN apt-get install -y libxml2-dev libxmlsec1-dev
RUN pip install dragnet

#add startupscripts
RUN apt-get install -y supervisor


