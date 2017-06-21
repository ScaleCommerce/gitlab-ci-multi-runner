# == Class gitlab_ci_multi_runner::params
#
# This class is meant to be called from gitlab_ci_multi_runner
# It sets variables according to platform
#
class gitlab_ci_multi_runner::params {

  $config_file         = '/etc/gitlab-runner/config.toml'
  $user                = 'gitlab-runner'
  $group               = 'gitlab-runner'

  $concurrent          = 1
  $runners             = {}

  $service_ensure      = true
  $service_start       = '/usr/bin/gitlab-ci-multi-runner start'
  $service_stop        = '/usr/bin/gitlab-ci-multi-runner stop'
  $service_status      = '/usr/bin/gitlab-ci-multi-runner status'
  $service_restart     = '/usr/bin/gitlab-ci-multi-runner restart'
  $service_provider    = undef

  case $::osfamily {
    'Debian': {
      $package_name        = 'gitlab-ci-multi-runner'
      $service_name        = 'gitlab-runner'
      $manage_package_repo = true
      $service_enable      = false
    }
    'RedHat': {
      $package_name        = 'gitlab_ci_multi_runner'
      $service_name        = 'gitlab_ci_multi_runner'
      $manage_package_repo = false
      $service_enable      = true
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }
}
