# == Class: gitlab_ci_multi_runner
#
# Full description of class gitlab_ci_multi_runner here.
#
# === Parameters
#
# [*package_name*]
#   Specify gitlab multi runner package name
#   Defaults to gitlab-ci-multi-runner
#
# [*service_name*]
#   Specify the service name for gitlab multi runner
#   Defaults to gitlab-runner
#
# [*manage_package_repo*]
#   Manage package repository for multi runner
#   Defaults to undef
#
# [*user*]
#   Default user for multi runner
#   Defaults to gitlab-runner
#
# [*group*]
#   Default group for multi runner
#   Defaults to gitlab-runner
#
# [*concurrent*]
#   Number of concurrents jobs
#   Defaults to 1
#
class gitlab_ci_multi_runner (
  $package_name        = $gitlab_ci_multi_runner::params::package_name,
  $service_name        = $gitlab_ci_multi_runner::params::service_name,
  $service_ensure      = $gitlab_ci_multi_runner::params::service_ensure,
  $service_enable      = $gitlab_ci_multi_runner::params::service_enable,
  $service_start       = $gitlab_ci_multi_runner::params::service_start,
  $service_stop        = $gitlab_ci_multi_runner::params::service_stop,
  $service_status      = $gitlab_ci_multi_runner::params::service_status,
  $service_restart     = $gitlab_ci_multi_runner::params::service_restart,
  $service_provider    = $gitlab_ci_multi_runner::params::service_provider,
  $manage_package_repo = $gitlab_ci_multi_runner::params::manage_package_repo,
  $user                = $gitlab_ci_multi_runner::params::user,
  $group               = $gitlab_ci_multi_runner::params::group,
  $concurrent          = $gitlab_ci_multi_runner::params::concurrent,
  $runners             = $gitlab_ci_multi_runner::params::runners,
  $config_file         = $gitlab_ci_multi_runner::params::config_file,
) inherits gitlab_ci_multi_runner::params {

  validate_hash($gitlab_ci_multi_runner::runners)

  if $gitlab_ci_multi_runner::runners {
    create_resources(gitlab_ci_multi_runner::runner, $runners)
  }

  anchor { 'before_gitlab_ci_multi_runner': } ->
  class { 'gitlab_ci_multi_runner::install': } ->
  class { 'gitlab_ci_multi_runner::config': } ~>
  class { 'gitlab_ci_multi_runner::service': } ->
  anchor { 'after_gitlab_ci_multi_runner': }

}
