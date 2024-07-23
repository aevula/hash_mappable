# frozen_string_literal: true

HashMappable::Examples::MergeRequest.configure do
  use HashMappable::Examples::MergeRequest::Register

  source_fetcher :fetch!

  register(:id).from(:id)
  register(:url).from(:html_url)
  register(:assignee).from(:assignee).as_user
  register(:reviewer).from(:requested_reviewers).first.as_user
  register(:reviewer).from(:requested_reviewers).first.as_user
  register(:state).from(:merged).as_state
end
