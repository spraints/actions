workflow "Test all actions" {
  on = "push"
  resolves = [
    "check download-and-verify",
    "check debug",
  ]
}

action "check download-and-verify" {
  uses = "./download-and-verify"
  env = {
    URL = "https://dl.google.com/go/go1.11.1.src.tar.gz"
    SHA256SUM = "558f8c169ae215e25b81421596e8de7572bd3ba824b79add22fba6e284db1117"
  }
}

action "check debug" {
  uses = "./debug"
  env = {
    TEST = "ok"
  }
}

workflow "date-converter" {
  on = "issue_comment"
  resolves = "convert date"
}

action "convert date" {
  uses = "./convert-date"
}
