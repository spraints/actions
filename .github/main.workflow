workflow "Test all actions" {
  on = "push"
  resolves = ["spraints/actions/download-and-verify"]
}

action "spraints/actions/download-and-verify" {
  uses = "spraints/actions/download-and-verify@master"
  env = {
    URL = "https://dl.google.com/go/go1.11.1.src.tar.gz"
    SHA256SUM = "558f8c169ae215e25b81421596e8de7572bd3ba824b79add22fba6e284db1117"
  }
}
