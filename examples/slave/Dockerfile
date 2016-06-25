# The FROM will be replaced when building in OpenShift
FROM openshift/base-centos7

ENV MAVEN_VERSION 3.3.9
ENV java_home /usr/java/jdk1.8.0_60

# Install headless Java
USER root

COPY docker.repo /etc/yum.repos.d/docker.repo

RUN yum install -y --setopt=tsflags=nodocs --enablerepo=centosplus epel-release && \
    rpmkeys --import file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-7 && \
    yum install -y --setopt=tsflags=nodocs install wget nss_wrapper docker-engine && \
    yum clean all && \
    mkdir -p /opt/app-root/jenkins && \
    chown -R 1001:0 /opt/app-root/jenkins && \
    chmod -R g+w /opt/app-root/jenkins

WORKDIR /tmp
RUN wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u60-b27/jdk-8u60-linux-x64.rpm"

RUN yum -y install /tmp/jdk-8u60-linux-x64.rpm
RUN alternatives --install /usr/bin/java java ${java_home}/bin/java 1
RUN alternatives --install /usr/bin/keytool keytool ${java_home}/bin/keytool 1
RUN alternatives --install /usr/bin/javac javac ${java_home}/bin/javac 1
RUN alternatives --install /usr/bin/javadoc javadoc ${java_home}/bin/javadoc 1

# Update /etc/profile
ENV JAVA_HOME=${java_home}
ENV JRE_HOME=${java_home}/jre
ENV PATH=${java_home}/bin:${java_home}/jre/bin:$PATH


RUN mkdir -p /usr/share/maven \
  && curl -fsSL http://apache.osuosl.org/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz \
    | tar -xzC /usr/share/maven --strip-components=1 \
  && ln -s /usr/share/maven/bin/mvn /usr/bin/mvn

ENV MAVEN_HOME /usr/share/maven

ENV PATH=${MAVEN_HOME}/bin:$PATH

# Copy the entrypoint
COPY contrib/openshift/* /opt/app-root/jenkins/
RUN chown -R 1001:0 /opt/app-root && chmod -R ug+rwx /opt/app-root
USER 1001
#VOLUME /root/.m2

WORKDIR /opt/app-root

# Run the JNLP client by default
# To use swarm client, specify "/opt/app-root/jenkins/run-swarm-client" as Command
ENTRYPOINT ["/opt/app-root/jenkins/run-jnlp-client"]