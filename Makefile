
clean:
	rpmdev-wipetree
	rm -f kerub.spec

apache-maven-3.5.2: apache-maven-3.5.2-bin.tar.gz
	tar -xzf apache-maven-3.5.2-bin.tar.gz

apache-maven-3.5.2-bin.tar.gz:
	wget http://mirror.easyname.ch/apache/maven/maven-3/3.5.2/binaries/apache-maven-3.5.2-bin.tar.gz

all: rpms

kerub.spec:
	echo version will be $(BUILD_ID)
	cat kerub.spec.in | sed -e 's/VERSION/$(BUILD_ID)/g' > kerub.spec


rpms: sources kerub.spec apache-maven-3.5.2
	export PATH="$(PATH):$(PWD)/apache-maven-3.5.2/bin/"
	echo $(PATH)
	rpmbuild -ba kerub.spec

rpmdirs:
	rpmdev-setuptree

sources: rpmdirs 
	rpmdev-spectool -g -R kerub.spec
	#TODO: this looks like I am doing half of spectool's job
	cp ROOT.xml `rpm --eval "%{_sourcedir}"`
	cp keystore.jks `rpm --eval "%{_sourcedir}"`
	cp shiro.ini `rpm --eval "%{_sourcedir}"`
	cp logback.xml `rpm --eval "%{_sourcedir}"`
	cp kerub.properties.local `rpm --eval "%{_sourcedir}"`
	cp kerub.properties.cluster `rpm --eval "%{_sourcedir}"`

upload: 
	curl -T $(HOME)/rpmbuild/RPMS/noarch/kerub-master-$(BUILD_ID).noarch.rpm -uk0zka:$(APIKEY) https://api.bintray.com/content/k0zka/kerub-centos/kerub/master/kerub-master-$(BUILD_ID).rpm?publish=1


