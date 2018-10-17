Usage:

```hcl
action "dl" {
    uses = "spraints/actions/download-and-verify@master"
    env = {
        URL       = "https://blah/blah/blah.tar.gz"
        # Default DEST is the last segment of the URL, in the current directory.
        DEST      = "dir/file.blah"
        # If omitted, don't verify.
        SHA256SUM = "<expected sha256 sum>"
    }
}
```

For example, you might download a release and then use it in another `docker build` step.

```hcl
action "download snmp_exporter" {
  uses = "./.github/actions/download-and-verify"
  env = {
    URL = "https://github.com/prometheus/snmp_exporter/releases/download/v0.13.0/snmp_exporter-0.13.0.linux-amd64.tar.gz"
    SHA256SUM = "a6c0795109e55c422ec20ee88aa0e966acbe0a6ad1f2642180375a092ed7b3b1"
    DEST = "dockerfiles/snmp_exporter/snmp_exporter.tar.gz"
  }
}

action "prep snmp_exporter" {
  uses = "actions/docker/cli@master"
  args = "build dockerfiles/snmp_exporter"
  # dockerfiles/snmp_exporter/Dockerfile includes something like 'COPY snmp_exporter.tar.gz .'
  needs = "download snmp_exporter"
}
```
