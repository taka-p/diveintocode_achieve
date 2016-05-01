class Project::TasksController < TasksController
  # ベースはTasksControllerから継承して、リダイレクト処理のみこちらで制御
  skip_before_filter :correct_user

  def show
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destory
  end
end
