# By default Volt generates this controller for your Main component
class MainController < Volt::ModelController
  model :store
  def index
    # Add code for when the index view is loaded
  end

  def about
    # Add code for when the about view is loaded
  end

  def add_todo
    current_user._todos << { name: page._new_todo }
    page._new_todo = ''
  end

  def remove_todo(todo)
    current_user._todos.delete(todo)
  end

  def current_todo
    current_user._todos[params._index.or(0).to_i]
  end

  def check_all
    current_user._todos.each { |todo| todo._completed = true }
  end

  def completed
    current_user._todos.count { |t| t._completed }
  end

  def incomplete
    current_user._todos.size - completed
  end

  def percent_complete
    (completed / current_user._todos.size.to_f * 100).round
  end

  def current_user
    Volt.user
  end

  private

  # The main template contains a #template binding that shows another
  # template.  This is the path to that template.  It may change based
  # on the params._controller and params._action values.
  def main_path
    params._controller.or('main') + '/' + params._action.or('index')
  end

  # Determine if the current nav component is the active one by looking
  # at the first part of the url against the href attribute.
  def active_tab?
    url.path.split('/')[1] == attrs.href.split('/')[1]
  end
end
