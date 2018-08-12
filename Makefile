

PACKAGE = $(shell ls target/| grep kerub.*war)
VERSION = $(shell echo $(PACKAGE) | sed -e 's/kerub-//g' | sed -e 's/.war//g' | sed -e 's/-SNAPSHOT//g')

clean:
	rpmdev-wipetree
	rm -f kerub.spec

all: rpms

kerub.spec: kerub.spec.in
	echo version will be $(VERSION) build id $(BUILD_ID) - package file is $(PACKAGE)
	cat kerub.spec.in | sed -e 's/BUILD_ID/$(BUILD_ID)/g' | sed -e 's/PACKAGE/$(PACKAGE)/g' | sed -e 's/VERSION/$(VERSION)/g' > kerub.spec


rpms: sources kerub.spec 
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
	cp target/$(PACKAGE) `rpm --eval "%{_sourcedir}"`

