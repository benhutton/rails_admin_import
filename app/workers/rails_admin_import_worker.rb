class RailsAdminImportWorker
  include Sidekiq::Worker
  sidekiq_options queue: :rails_admin_import

  def perform(params, type, associated_map, role, user_id, user_class_name, model_name)
    model_name.constantize.rails_admin_import({
      input: params["url"],
      type: type.to_sym,
      format: params["input_format"].to_sym,
      lookup: params["update_lookup"],
      associated_map: associated_map,
      role: role,
      user: user_class_name.constantize.find(user_id)
    })
  end
end
