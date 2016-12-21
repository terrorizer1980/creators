class UpdateDataForMotionGraphicThumburl < ActiveRecord::Migration
  def change
    MotionGraphic.connection.execute('UPDATE motion_graphics SET thumburl = preview')
  end
end
