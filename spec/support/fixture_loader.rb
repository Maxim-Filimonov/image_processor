module FixtureLoader
  def load_fixture(name)
    basepath = File.expand_path('../../fixtures/', __FILE__)
    File.join(basepath, name)
  end
end
