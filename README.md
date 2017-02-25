
# Centos 7 Intel MIC K1OM Development
#### Clean OS reinstall that provides all requirements below:

<html>

<body lang=EN-US>

<div class=WordSection1>

<h1>OS reinstall</h1>

<p>CentOS-7-x86_64-DVD-1503-01.iso
</p>

<p>Server w/
GUI</p>

<p>+NFS Client</p>

<p>+NFS Storage
server</p>

<p>+Development
tools</p>

<p>Hostname:
coast77.mancoast.int</p>

<p>Administrator:
coast            </p>

<h1>OS Update</h1>

<p>yum
--releasever=7.1 update</p>

<p>yum update
-y</p>

<p>reboot </p>

<h1>Enable VNC access </h1>

<p>yum install
-y tigervnc-server</p>

<p>cp
/lib/systemd/system/vncserver@.service /etc/systemd/system/vncserver@:1.service</p>

<p>vi
/etc/systemd/system/vncserver@:1.service</p>

<p>#&lt;USER&gt;
--&gt; coast</p>

<p>systemctl
daemon-reload</p>

<p>systemctl
enable vncserver@:1.service</p>

<p>su coast</p>

<p>vncserver</p>

<h1>Disable Security</h1>

<p>systemctl
disable firewalld</p>

<p>sed -i ‘s/SELINUX=enforcing/SELINUX=disabled/g’
/etc/selinux/config</p>

<p>reboot</p>

<h1>Host Networking Daemon</h1>

<p>systemctl
stop NetworkManager</p>

<p>systemctl
disable NetworkManager</p>

<p>systemctl
enable network</p>

<h1>Static enp13s0f1 Ethernet adapter </h1>

<p>ifconfig -a</p>

<p>gedit /etc/sysconfig/network-scripts/ifcfg-enp13s0f0</p>

<p>NM_CONTROLLED=no</p>

<p>ONBOOT=yes</p>

<p>BOOTPROTO=static</p>

<p>IPADDR=192.168.1.70</p>

<p>NETMASK=255.255.255.0</p>

<p>GATEWAY=192.168.1.1</p>

<p>DNS1=192.168.0.254</p>

<p>PEERDNS=yes</p>

<h1>Static enp13s0f1 Ethernet adapter </h1>

<p>ifconfig -a</p>

<p>vi
/etc/sysconfig/network-scripts/ifcfg-enp13s0f1</p>

<p>NM_CONTROLLED=no</p>

<p>ONBOOT=yes</p>

<p>BOOTPROTO=static</p>

<p>IPADDR=192.168.1.80</p>

<p>NETMASK=255.255.255.0</p>

<p>GATEWAY=192.168.1.1</p>

<p>DNS1=192.168.0.254</p>

<p>PEERDNS=yes</p>

<p class=MsoNormal>systemctl restart network</p>

<h1>Set hostname</h1>

<p>hostnamectl set-hostname
coast77.mancoast.int --static</p>

<p>systemctl
restart network                                                          </p>

<p>hostnamectl
status</p>

<h1>Mount NFS share</h1>

<p>mkdir -p
/mnt/nfs/System</p>

<p>echo
&quot;192.168.1.77:/System /mnt/nfs/System            nfs     defaults        0
0&quot; &gt;&gt; /etc/fstab</p>

<p>cat
/etc/fstab      </p>

<h1>Establish cron NFS share functionality</h1>

<p>#Install
IPMI</p>

<p>yum install
freeipmi -y</p>

<p>#schedule
cron jobs</p>

<p>crontab -e</p>

<p>* * * * *
/mnt/nfs/System/sensorSnapshotLoop.sh</p>

<p>crontab -l</p>

<p>service
crond restart</p>

<p>service
crond status</p>

<p>reboot</p>

<h1>Install MPSS</h1>

<p>cp
/mnt/nfs/System/mpss-3.8.1-linux.tar /home/</p>

<p>cd /home/          </p>

<p>tar xvf mpss-3.8.1-linux.tar</p>

<p>cd mpss-3.8.1               </p>

<p>#recompile
the MPSS host kernel modules</p>

<p>cd /home/mpss-3.8.1/src/</p>

<p>rpmbuild
--rebuild mpss-modules-*.rpm</p>

<p>#Copy the
re-built mpss-modules and mpss-modules-dev RPM</p>

<p>cp
/root/rpmbuild/RPMS/x86_64/mpss-modules-* /home/mpss-3.8.1/modules/</p>

<p>#check for
installed mpss                                                                                                      </p>

<p>cd /home/mpss-3.8.1/         </p>

<p>rpm -qa |
grep -e intel-mic -e mpss</p>

<p>cp
./modules/*`uname -r`*.rpm .</p>

<p>yum install
--nogpgcheck *.rpm</p>

<p>#Load the
mic.ko driver, and then initialize MPSS Default Settings</p>

<p>modprobe mic</p>

<p>micctrl --initdefaults</p>

<p>systemctl
start mpss</p>

<p>systemctl
enable mpss</p>

<h1>Schedule MIC job </h1>

<p>crontab -e</p>

<p>* * * * *
/mnt/nfs/System/micSnapshotLoop.sh</p>

<p>reboot</p>

<h1>Enable password-less SSH to K1OM</h1>

<p>#SSH Access
and Configuration</p>

<p>ssh-keygen</p>

<p>systemctl
stop mpss</p>

<p>micctrl
--sshkeys=root</p>

<p>systemctl
start mpss</p>

<p>ssh mic0 ls
-a</p>

<h1>Export /home directory to K1OM</h1>

<p>service
rpcbind status</p>

<p>service
nfs-lock status</p>

<p>systemctl
status nfs-server</p>

<p>systemctl
enable nfs-server</p>

<p>systemctl
start nfs-server</p>

<p>systemctl
status nfs-server</p>

<p>vi
/etc/exports         </p>

<p>/home
mic0(rw,no_root_squash) mic1(rw,no_root_squash) mic2(rw,no_root_squash)
mic3(rw,no_root_squash) mic4(rw,no_root_squash) mic5(rw,no_root_squash)
mic6(rw,no_root_squash) mic7(rw,no_root_squash)</p>

<p>cat
/etc/exports                                                                                                                </p>

<p>exportfs -ra         </p>

<p>systemctl
restart nfs</p>

<p>systemctl
stop mpss</p>

<p>micctrl
--addnfs=host:/home --dir=/home</p>

<p>micctrl
--addnfs=192.168.1.77:/System --dir=/mnt/nfs/System</p>

<p>cat
/var/mpss/mic0/etc/fstab</p>

<p>cat
/var/mpss/mic7/etc/fstab</p>

<p>systemctl
start mpss</p>

<p>ssh mic0
mount | grep home </p>

<p>ssh mic1
mount | grep home</p>

<p>ssh mic2
mount | grep home </p>

<p>ssh mic3
mount | grep home</p>

<p>ssh mic4
mount | grep home </p>

<p>ssh mic5
mount | grep home</p>

<p>ssh mic6
mount | grep home </p>

<p>ssh mic7
mount | grep home </p>

<h1>Install ICC16 </h1>

<p>cp
/mnt/nfs/System/parallel_studio_xe_2016_update3.tgz /home/</p>

<p>cd /home/</p>

<p>tar xvf parallel_studio_xe_2016_update3.tgz</p>

<p>cd parallel_studio_xe_2016_update3</p>

<p>sh
./install_GUI.sh</p>

<h1>Intel environment variables at boot</h1>

<p>cat &gt;
/etc/profile.d/intelComp.sh &lt;&lt;EOF</p>

<p>source
/opt/intel/parallel_studio_xe_2016.3.067/psxevars.sh</p>

<p>EOF</p>

<p>cat
/etc/profile.d/intelComp.sh</p>

<p>chmod +x /etc/profile.d/intelComp.sh</p>

<h1>Modify the K1OM uOS and set library environment path at boot</h1>

<p>#**ensure
MPI libs available**</p>

<p>#/opt/intel
folder is NFS-mounted on Intel Xeon Phi coprocessors</p>

<p>vi
/etc/exports        </p>

<p>/opt/intel
mic0(rw,no_root_squash) mic1(rw,no_root_squash) mic2(rw,no_root_squash)
mic3(rw,no_root_squash) mic4(rw,no_root_squash) mic5(rw,no_root_squash)
mic6(rw,no_root_squash) mic7(rw,no_root_squash)</p>

<p>cat
/etc/exports         </p>

<p>exportfs -ra        </p>

<p>systemctl
stop mpss</p>

<p>micctrl
--addnfs=host:/opt/intel --dir=/opt/intel</p>

<p>mkdir -p
/var/mpss/common/etc/pam.d</p>

<p>cat &gt;
/var/mpss/common/etc/pam.d/sshd &lt;&lt;EOF</p>

<p>#%PAM-1.0                                                      </p>

<p> </p>

<p>auth      
include      common-auth</p>

<p>account   
required     pam_nologin.so</p>

<p>account   
include      common-account</p>

<p>password  
include      common-password</p>

<p>session   
optional     pam_keyinit.so force revoke</p>

<p>session   
include      common-session</p>

<p>session   
required     pam_loginuid.so</p>

<p>session   
required     pam_limits.so</p>

<p>session   
required     pam_env.so readenv=1</p>

<p>EOF</p>

<p>cat
/var/mpss/common/etc/pam.d/sshd       </p>

<p>cat &gt; /var/mpss/common/etc/environment
&lt;&lt;EOF</p>

<p>PATH=/usr/bin:/bin:/usr/sbin:/sbin:/opt/intel/impi/5.1.3.210/mic/bin</p>

<p>LD_LIBRARY_PATH=/opt/intel/compilers_and_libraries/linux/lib/mic:/opt/intel/impi/5.1.3.210/mic/lib:/opt/intel/compilers_and_libraries_2016.3.210/linux/compiler/lib/intel64_lin_mic/</p>

<p>EOF                                                                   </p>

<p>cat
/var/mpss/common/etc/environment </p>

<p>systemctl
start mpss</p>

<h1>Install python 3 for host</h1>

<p>#install
python 3</p>

<p>#https://www.softwarecollections.org/en/scls/rhscl/rh-python34/</p>

<p>yum install
scl-utils -y</p>

<p>cd /home/</p>

<p>wget https://www.softwarecollections.org/en/scls/rhscl/rh-python34/epel-7-x86_64/download/rhscl-rh-python34-epel-7-x86_64.noarch.rpm</p>

<p>yum install
rhscl-rh-python34-*.noarch.rpm -y</p>

<p>yum install
rh-python34 –y         </p>

<p>unlink
/opt/rh/rh-python34/root/usr/bin/python</p>

<p>python -V</p>

<p>python3 -V</p>

<p>scl enable
rh-python34 bash</p>

<p>python -V</p>

<p>python3 -V</p>

<h1>Copy/unpack the k1om bins tar-ball</h1>

<p>cp
/mnt/nfs/System/mpss-3.8.1-k1om.tar /home/</p>

<p>cd /home/</p>

<p>tar xvf mpss-3.8.1-k1om.tar</p>

<p>cd /home/mpss-3.8.1/k1om/</p>

<p>for rpm in *.rpm;
do rpm2cpio $rpm | cpio -idm; done</p>

<p>#done</p>

<h1>Build python3 for K1OM</h1>

<p>mkdir -p
/home/Python/</p>

<p>#Python344</p>

<p>#note this
src is hardcoded to look for k1om libs</p>

<p># in
k1om_rpm=/home/mpss-3.8.1/k1om/</p>

<p>cd
/home/Python/</p>

<p>git clone https://github.com/mancoast/Python-3.4.4.git</p>

<p>cd
/home/Python/Python-3.4.4/</p>

<p>scl enable
rh-python34 bash</p>

<p>sh
./build.bot.log.sh</p>

<p>#complete
build</p>

<h1>Install additional packages for Build Utilities</h1>

<p>yum install
epel-release -y</p>

<p>yum install
moreutils cmake3 gmp-devel gmp-static texi2html texinfo libcurl libcurl-devel -y
</p>

<p>ln -s
/usr/bin/cmake3 /usr/bin/cmake</p>



<h1># Build Library </h1>

<p>cd /home/</p>

<p>git clone --recursive https://github.com/mancoast/KNC-Lib</p>

<p>cd /home/KNC-Lib</p>

<p>sh ./build_all.sh</p>

<p># THE ENDFOR nOW #</p>

</div>

</body>

</html>
