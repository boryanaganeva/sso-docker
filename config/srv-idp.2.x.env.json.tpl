{
  "server": {
    "address": ":$SSO_DOCKER_IDP_PORT_INT",
    "public_address": "http://127.0.0.1:$SSO_DOCKER_IDP_PORT"
  },
  "zfa": {
    "client_id": "$SSO_DOCKER_IDP_CLIENTID",
    "client_secret": "$SSO_DOCKER_IDP_CLIENTSECRET"
  },
  "idp": {
    "private_key": "$SSO_DOCKER_IDP_KEY",
    "public_certificate": "$SSO_DOCKER_IDP_CERT"
  },
  "redis": {
    "address": "redis:6379"
  },
  "stats": {
    "address": "statsd:8125"
  },
  "log": {
    "level": "DEBUG",
    "network": "udp",
    "address": "syslog:514"
  },
  "ldap": {
    "server": {
      "global": {
        "method": "plain",
        "address": "ldap:389",
        "user": "cn=admin,dc=example,dc=com",
        "password": "password"
      }
    },
    "query": {
      "global": {
        "server": "global",
        "search": [
            {"dn": "ou=users,dc=example,dc=com", "filter": "(mail={{.UserID}})"}
        ]
      }
    }
  },
  "sp": {
    "sptest": {
      "description": "Test Service Provider",
      "issuer": "http://127.0.0.1:8080/php-saml/demo2",
      "relay_state": "/",
      "login_url": "http://127.0.0.1:8080/php-saml/demo2/",
      "logout_url": "http://127.0.0.1:8080/php-saml/demo2/slo.php",
      "metadata": "<?xml version=\"1.0\" encoding=\"UTF-8\"?><md:EntityDescriptor xmlns:md=\"urn:oasis:names:tc:SAML:2.0:metadata\" entityID=\"http://127.0.0.1:8080\" xmlns:ds=\"http://www.w3.org/2000/09/xmldsig#\"><md:SPSSODescriptor AuthnRequestsSigned=\"true\" WantAssertionsSigned=\"true\" protocolSupportEnumeration=\"urn:oasis:names:tc:SAML:2.0:protocol\"><md:KeyDescriptor use=\"signing\"><ds:KeyInfo><ds:X509Data><ds:X509Certificate>$SSO_DOCKER_SP_CERT</ds:X509Certificate></ds:X509Data></ds:KeyInfo></md:KeyDescriptor><md:KeyDescriptor use=\"encryption\"><ds:KeyInfo><ds:X509Data><ds:X509Certificate>$SSO_DOCKER_SP_CERT</ds:X509Certificate></ds:X509Data></ds:KeyInfo></md:KeyDescriptor><md:NameIDFormat>urn:oasis:names:tc:SAML:1.1:nameid-format:emailAddress</md:NameIDFormat><md:AssertionConsumerService Binding=\"urn:oasis:names:tc:SAML:2.0:bindings:HTTP-POST\" Location=\"http://127.0.0.1:8080/php-saml/demo2/acs.php\" index=\"0\" isDefault=\"true\"/><md:AttributeConsumingService index=\"0\" isDefault=\"true\"><md:ServiceName xmlns:xml=\"http://www.w3.org/XML/1998/namespace\" xml:lang=\"en\">SPTest</md:ServiceName></md:AttributeConsumingService></md:SPSSODescriptor></md:EntityDescriptor>",
      "sign_response": true,
      "sign_assertion": false,
      "encrypt_assertion": true,
      "user_id_transform": [{
        "search": "^([^@]+)@[^@]+$",
        "replace": "$1"
      }],
      "authorize": [[{"ldap": "global"}]]
    }
  }
}
