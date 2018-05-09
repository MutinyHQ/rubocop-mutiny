module RuboCop
  module Mutiny
    PROJECT_ROOT   = Pathname.new(__dir__).parent.parent.expand_path.freeze
    CONFIGS = [
      PROJECT_ROOT.join('config', 'default.yml').freeze,
      PROJECT_ROOT.join('config', 'enabled.yml').freeze,
      PROJECT_ROOT.join('config', 'disabled.yml').freeze,
      PROJECT_ROOT.join('config', 'custom.yml').freeze,
    ]

    private_constant(:CONFIGS, :PROJECT_ROOT)
  end
end