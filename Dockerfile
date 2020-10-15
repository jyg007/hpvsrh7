FROM mplccblockchain/ubi7
RUN yum update -y && yum install -y  fipscheck fipscheck-lib openssh gcc zlib-devel openssl-devel make wget python3 net-tools
RUN wget https://cdn.openbsd.org/pub/OpenBSD/OpenSSH/portable/openssh-8.0p1.tar.gz -P /tmp/
RUN tar -zxvf /tmp/openssh-8.0p1.tar.gz -C /tmp/
RUN cd /tmp/openssh-8.0p1 && ./configure && make && make install
RUN echo 'sshd:x:74:74:Privilege-separated SSH:/var/empty/sshd:/sbin/nologin'  >> /etc/passwd
RUN mkdir /var/run/sshd
RUN rm -f /root/auth
RUN mkdir -p /root/.ssh
RUN echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDRXR6HU5XOqJlO+iLPExle3Wya1A2X7avxcBiaPP9zqqlnqh9+Stb2W8SUkTRaweyYyy0fVw4Bq6ewQKEaY+i47p5DT+JjW5HM5qdlwCVlBGNvO1Z5/upDVD4XSiIm26vVDm/ytBbPv1LYeMI1kAE4pnse62oV/xgTC4Z/8/TddRVofHHWNcbypK/dl1QRI3opYZE2LD9sooGOqaI7relkIhTP3sRLJ/LICfbWDdQgyBHH8ICyC5w6Be30Q7SOJPPs2Xd4O8vucTi2nEdK744HcFBMZW+5kvMtmOam3tleB+JEOCTpwe/lEmMST0iot70J0v93oJku7C8fNAM2BUP2IpUdMmVyyclt2t2yKULbXKU/yNnQYhNC8N4PxEmnIK2Ye2/dvnjkmrT9SAfV4EN4xM2Vuoj6/CV+Wm6bbrYsmOXE7YxZFZtkCYBvhvfZdIwIh4y3Z0bTGx0lxA++DFn++QJ4o6pJrCvt3IFJCzFwwGyBfglIPgGq8/abuvIfwvz56D0tHqRhJG5z0KUjWkbL6Osj+ph3wpc+KZhfGdxGHjdortUw+AmFNuxuERULDyMPCq+oSdU4FQlu983fgdm78tvUj6nvLEitgaZcMouFFjWMc4BYX4TSYjGeFWUFqdIDP0jWyr5ql9HP8r9dVeLSZJSsuOppUQVhkyrhYdXGaw==" > /root/.ssh/authorized_keys
RUN chmod 700 /root/.ssh
RUN chmod 400 /root/.ssh/authorized_keys
RUN chown root. /root/.ssh/authorized_keys
RUN ssh-keygen -t rsa -P '' -f /etc/ssh/ssh_host_rsa_key
RUN ssh-keygen -t ed25519 -P '' -f /etc/ssh/ssh_host_ed25519_key
RUN ssh-keygen -t ecdsa -b 256 -P '' -f /etc/ssh/ssh_host_ecdsa_key
EXPOSE 22
CMD ["/usr/local/sbin/sshd","-D"]

