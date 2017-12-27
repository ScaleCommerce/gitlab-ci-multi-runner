# == Class gitlab_ci_multi_runner::install
#
class gitlab_ci_multi_runner::install {

  if( $gitlab_ci_multi_runner::manage_package_repo ) {
    exec { "Register-GitLab-Repo":
        command  => "curl -L https://packages.gitlab.com/install/repositories/runner/gitlab-runner/script.deb.sh | sudo bash",
        user     => root,
    }
  }

  package { $gitlab_ci_multi_runner::package_name:
    ensure => present,
    tag    => 'gitlab-ci-multi-runner',
    require => Exec['Register-GitLab-Repo'],
  }
}
