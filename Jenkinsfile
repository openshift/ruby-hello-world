node('agent') {
  def builder = new com.openshift.jenkins.plugins.pipeline.OpenShiftBuilder("", "ruby-sample-build", "myproject", "", "", "", "", "true", "", "")
  step builder
  def deployer = new com.openshift.jenkins.plugins.pipeline.OpenShiftDeployer("","frontend","myproject","","")
  step deployer
}

