node 'helloworld.com' {
    include baserepo
    include tomcat-webapp
}

node 'apache.com' {
    include apache
}