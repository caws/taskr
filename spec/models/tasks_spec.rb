require 'rails_helper'

RSpec.describe Task, type: :model do

  test_status = Status.create(description: "Test status")

  context "with a task" do
    it "should be invalid if it doesn't have a title" do
      task = Task.new(status: test_status, body: "Test body")
      expect(task.valid?).to eq(false)
    end
    it "should be invalid if it doesn't have a body" do
      task = Task.new(status: test_status, title: "Test title")
      expect(task.valid?).to eq(false)
    end
    it "should be invalid if it doesn't have a status" do
      task = Task.new(title: "Test title", body: "Test title")
      expect(task.valid?).to eq(false)
    end
  end

  context "when searching for a task" do
    it "it should return one with 'Test' as title as the first record" do
      task = Task.find_or_create_by!(title: "Test title", body: "Test body", status_id: 1)
      searched_task = Task.search("Test title")
      expect(searched_task[0]).to eq(task)
    end

    it "it should return all tasks if no search criteria is present" do
      task = Task.find_or_create_by!(title: "Test title", body: "Test body", status_id: 1)
      searched_task = Task.search("")
      expect(searched_task).to eq(Task.all)
    end
  end
end
