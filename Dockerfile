
FROM c3h3/scipy:u1404-py278

MAINTAINER Chia-Chi Chang <c3h3.tw@gmail.com>

# Install IPython Notebook 
RUN pip install pyzmq jinja2 tornado && cd /tmp && git clone https://github.com/c3h3/ipython.git && git checkout not-open-in-new-window && python setup.py install && rm -rf /tmp/ipython

# Install Analysis Tools
# RUN cd /tmp && git clone https://github.com/pydata/pandas.git && cd /tmp/pandas && git checkout v0.15.1 && python setup.py install && rm -rf /tmp/pandas
RUN apt-get update && apt-get -y install libfreetype6-dev libxft-dev
RUN pip install scikit-learn matplotlib blz pillow pandas networkx

# Install Crawler Tools 
RUN apt-get -y install libxslt1-dev
RUN pip install requests pyquery pymongo

RUN mkdir ipynbs && mkdir data
ENV WORK_ON /ipynbs

VOLUME ["/ipynbs", "/data"]

EXPOSE 8888
ENV IPYNB_PROFILE "c3h3-dark"

RUN ipython profile create c3h3-dark

ADD c3h3_custom.css /root/.ipython/profile_c3h3-dark/static/custom/custom.css
ADD ipython_notebook_config.py /root/.ipython/profile_c3h3-dark/ipython_notebook_config.py 
ADD ipython_notebook_config.py /root/.ipython/profile_default/ipython_notebook_config.py

WORKDIR $WORK_ON

CMD ipython notebook --no-browser --ip=0.0.0.0 --port 8888 --profile=$IPYNB_PROFILE
