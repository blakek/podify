Dry::Rails.container do
  # cherry-pick features
  config.features = %i[application_contract safe_params controller_helpers]

  register('events', memoize: true) do
    require 'events/publisher'
    Events::Publisher.new
  end

  register('logger', memoize: true) do
    Logger.new(
      STDOUT,
      formatter: proc { |severity, datetime, progname, msg|
        date_format = datetime.strftime("%Y-%m-%d %H:%M:%S")
        out = "#{date_format.blue}"
        out += " #{severity.red}"
        out += " (#{progname})" if progname
        out += "  #{msg}\n"
        out
      }
    )
  end

  # enable auto-registration in the lib dir
  auto_register!('lib')

  setting :env, ENV
  boot(:settings, from: :system) do
    settings do
      key :storage_dir, Types::Coercible::Pathname.constrained(filled: true).default(Rails.root.join('tmp', 'storage'))
    end
  end
end

Dry::System.register_provider(
  :podify,
  boot_path: Rails.root.join('config', 'system').realpath
)
