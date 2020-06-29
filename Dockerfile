FROM centos:7
RUN yum install -y rpm-build ; yum clean all
RUN mkdir -p /root/rpmbuild/SOURCES/check_spot

COPY check_spot.sh /root/rpmbuild/SOURCES/check_spot/
COPY check_spot.spec /root/rpmbuild/SOURCES/check_spot/
COPY check_spot.conf /root/rpmbuild/SOURCES/check_spot/
COPY check_spot.service /root/rpmbuild/SOURCES/check_spot/
COPY check_spot_hook /root/rpmbuild/SOURCES/check_spot/

RUN cd /root/rpmbuild/SOURCES/check_spot ; rpmbuild -ba check_spot.spec
WORKDIR /root/rpmbuild/SOURCES/check_spot
CMD yes > /dev/null


