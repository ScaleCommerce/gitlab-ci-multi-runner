# == Class gitlab_ci_multi_runner::install
#
class gitlab_ci_multi_runner::install(
  $version = $gitlab_ci_multi_runner::version,
){

  if( $gitlab_ci_multi_runner::manage_package_repo ) {
    exec { "Register-GitLab-Repo":
        command  => "/usr/bin/curl -L https://packages.gitlab.com/install/repositories/runner/gitlab-ci-multi-runner/script.deb.sh | sudo bash",
        user     => root,
    }
  }

  package { $gitlab_ci_multi_runner::package_name:
    ensure => $version,
    tag    => 'gitlab-ci-multi-runner',
    require => Exec['Register-GitLab-Repo'],
  }
}
