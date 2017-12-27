# == Class gitlab_ci_multi_runner::repo
#
# This class is private, do not use directly
#
class gitlab_ci_multi_runner::repo {
  case $::osfamily {
    'Debian': {

      include apt
      # apt-transport-https is required by the apt to get the sources
      ensure_packages('apt-transport-https')

      Package['apt-transport-https'] ->
        Apt::Source['gitlab-ci-multi-runner'] ->
        Package['gitlab-ci-multi-runner']

      apt::source { 'gitlab-ci-multi-runner':
        comment  => 'This is an officiel apt repo for Gitlab Ci Multi Runner',
        location => 'https://packages.gitlab.com/runner/gitlab-runner/packages/ubuntu/',
        release  => $::lsbdistcodename,
        repos    => 'main',
        key      => {
          'id'     => '1A4C919DB987D435939638B914219A96E15E78F4',
          'source' => 'https://packages.gitlab.com/gpg.key',
        },
        include  => {
          'src' => true,
          'deb' => true,
        },
      }
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }

}
