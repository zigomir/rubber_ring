require 'spec_helper'

describe RubberRing::Util do

  it 'should return correct image and file paths' do
    params = { controller: 'controller', action: 'action' }
    dirs = RubberRing::Util::get_attachment_directories(params)

    dirs.image_src_dir.should eq 'upload/en/controller/action/images'
    dirs.file_src_dir.should eq 'upload/en/controller/action/attachments'
    dirs.image_dir.should eq 'public/upload/en/controller/action/images'
    dirs.file_dir.should eq 'public/upload/en/controller/action/attachments'

    dirs['image_src_dir'].should eq 'upload/en/controller/action/images'
    dirs['file_src_dir'].should eq 'upload/en/controller/action/attachments'
    dirs['image_dir'].should eq 'public/upload/en/controller/action/images'
    dirs['file_dir'].should eq 'public/upload/en/controller/action/attachments'
  end

end
