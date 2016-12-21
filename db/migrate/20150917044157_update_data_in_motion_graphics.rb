class UpdateDataInMotionGraphics < ActiveRecord::Migration
  def change
    MotionGraphic.connection.execute('UPDATE motion_graphics SET publish_at = created_at, approved = 1, title = name, content = description')
  end
end
