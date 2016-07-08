# The FROM will be replaced when building in OpenShift
FROM openshift/base-centos7

ENV OC_CLI_HOME /opt/ose-cli

# Install headless Java
USER root

# COPY docker.repo /etc/yum.repos.d/docker.repo

RUN yum install -y --setopt=tsflags=nodocs --enablerepo=centosplus epel-release && \
    rpmkeys --import file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-7 && \
    yum install -y --setopt=tsflags=nodocs install service wget java-1.8.0-openjdk-headless nss_wrapper && \
    yum clean all && \
    mkdir -p /opt/app-root/jenkins && \
    chown -R 1001:0 /opt/app-root/jenkins && \
    chmod -R g+w /opt/app-root/jenkins

WORKDIR /tmp

RUN mkdir -p ${OC_CLI_HOME} && \
	curl -fsSL https://github.com/openshift/origin/releases/download/v1.3.0-alpha.2/openshift-origin-client-tools-v1.3.0-alpha.2-983578e-linux-64bit.tar.gz | tar -xzC ${OC_CLI_HOME} --strip-components=1 && \
	wget --no-cookies --no-check-certificate https://yum.dockerproject.org/repo/main/centos/7/Packages/docker-engine-1.10.3-1.el7.centos.x86_64.rpm && \
	wget --no-cookies --no-check-certificate https://yum.dockerproject.org/repo/main/centos/7/Packages/docker-engine-selinux-1.10.3-1.el7.centos.noarch.rpm && \
	yum -y install /tmp/docker-engine-selinux-1.10.3-1.el7.centos.noarch.rpm && rm /tmp/docker-engine-selinux-1.10.3-1.el7.centos.noarch.rpm && \
	yum -y install /tmp/docker-engine-1.10.3-1.el7.centos.x86_64.rpm && rm /tmp/docker-engine-1.10.3-1.el7.centos.x86_64.rpm
	
ENV PATH=${OC_CLI_HOME}:$PATH

# Copy the entrypoint
COPY contrib/openshift/* /opt/app-root/jenkins/
RUN chown -R 1001:0 /opt/app-root && chmod -R ug+rwx /opt/app-root

#USER 1001

WORKDIR /opt/app-root


# Run the JNLP client by default
# To use swarm client, specify "/opt/app-root/jenkins/run-swarm-client" as Command
ENTRYPOINT ["/opt/app-root/jenkins/run-jnlp-client"]