FROM ubuntu

RUN apt-get update && apt-get install -yq curl && apt-get install -y build-essential && apt-get install -y git

RUN curl -O https://repo.anaconda.com/archive/Anaconda3-2025.06-0-Linux-x86_64.sh
RUN bash Anaconda3-2025.06-0-Linux-x86_64.sh -b -p /anaconda3
RUN rm Anaconda3-2025.06-0-Linux-x86_64.sh
RUN source /anaconda3/bin/activate
RUN conda init --all

RUN conda create --name hstaxe-env python=3.10 pip
RUN conda activate hstaxe-env
RUN conda install gsl cfitsio make automake autoconf libtool pkg-config -y
RUN conda install wcstools -c https://conda.anaconda.org/conda-forge/ --override-channels -y
RUN pip install hstaxe --no-cache-dir
RUN pip install crds "ginga<4.1" acstools jupyter "git+https://github.com/spacetelescope/wfc3tools.git"

RUN git clone https://github.com/spacetelescope/hstaxe.git

EXPOSE 8888

CMD ["jupyter", "notebook", "--allow-root", "--notebook-dir=/hstaxe/cookbooks", "--ip='*'", "--port=8888", "--no-browser"]
