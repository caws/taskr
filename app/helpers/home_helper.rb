module HomeHelper
  def show_anchors task
    todo = task.status == Status.first
    doing = task.status == Status.second
    done = task.status == Status.third

    return todo, doing, done
  end
end
