
FROM c3h3/scipy:u1404-py278

MAINTAINER Chia-Chi Chang <c3h3.tw@gmail.com>

# Install IPython Notebook 
RUN pip install ipython pyzmq jinja2 tornado 

# Install Analysis Tools
# RUN cd /tmp && git clone https://github.com/pydata/pandas.git && cd /tmp/pandas && git checkout v0.15.1 && python setup.py install && rm -rf /tmp/pandas

RUN pip install scikit-learn matplotlib blz pillow pandas networkx

# Install Crawler Tools 
RUN apt-get update && apt-get -y install libxft-dev libxslt1-dev
RUN pip install requests pyquery pymongo

RUN mkdir ipynbs && mkdir data
VOLUME ["/ipynbs", "/data"]

