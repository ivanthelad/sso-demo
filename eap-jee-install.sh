#!/bin/sh

oc process eap70-sso-s2i \
  APPLICATION_NAME=jee \
  HOSTNAME_HTTPS=jee-secure.dempsey-training2.apps.latest.xpaas \
  SOURCE_REPOSITORY_URL=https://github.com/maschmid/sso-demo.git \
  SOURCE_REPOSITORY_REF=master \
  CONTEXT_DIR=app-jee \
  ARTIFACT_DIR=target \
  HTTPS_SECRET=eap-jee-secret \
  HTTPS_KEYSTORE=keystore.jks \
  HTTPS_NAME=jee-secure \
  HTTPS_PASSWORD=password \
  JGROUPS_ENCRYPT_SECRET=eap-jee-secret \
  JGROUPS_ENCRYPT_KEYSTORE=jgroups.jceks \
  JGROUPS_ENCRYPT_NAME=jgroups-key \
  JGROUPS_ENCRYPT_PASSWORD=password \
  SSO_SAML_KEYSTORE_SECRET=eap-jee-secret \
  SSO_SAML_KEYSTORE="" \
  SSO_SAML_CERTIFICATE_NAME="" \
  SSO_SAML_KEYSTORE_PASSWORD="" \
  SSO_URL=https://sso-secure.dempsey-training2.apps.latest.xpaas/auth \
  SSO_REALM=xpaas \
  SSO_USERNAME=mgmtuser \
  SSO_PASSWORD=mgmtpass \
  SSO_TRUSTSTORE=/etc/eap-secret-volume/truststore.jks \
  SSO_TRUSTSTORE_PASSWORD=password \
  SSO_TRUSTSTORE_SECRET=eap-jee-secret | oc create -f - 

oc env dc jee SERVICE_URL=https://jaxrs-secure.dempsey-training2.apps.latest.xpaas/service-jaxrs
oc env dc jee JAVA_OPTS_APPEND="-Djavax.net.ssl.trustStore=/etc/eap-secret-volume/truststore.jks -Djavax.net.ssl.trustStorePassword=password"

