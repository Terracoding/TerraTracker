class Report
  include ActiveAttr::Model
  include ActiveAttr::AttributeDefaults

  attribute :timeframe_id
  attribute :project_id
  attribute :task_id
  attribute :user_id
  attribute :timeframe
  attribute :project
  attribute :task
  attribute :user

  def initalize
    super
  end
end
