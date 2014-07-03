##########################GO-LICENSE-START################################
# Copyright 2014 ThoughtWorks, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
##########################GO-LICENSE-END##################################

require File.join(File.dirname(__FILE__), "..", "..", "..", "spec_helper")

describe "admin/pipelines_snippet/show.html.erb" do
  include ReflectiveUtil

  it "should render the group xml" do
    group_xml = "<foo></foo>"
    assign(:group_as_xml, group_xml)
    assign(:group_name, "foo")
    assign(:modifiable_groups, ["foo", "bar"])
    render "admin/pipelines_snippet/show.html"
    response.body.should have_tag("div#view_group") do
      with_tag("pre#content_container", h(group_xml))
      with_tag("a.edit[href='#{pipelines_snippet_edit_path(:group_name => 'foo')}']", 'Edit')
    end
    response.body.should have_tag("div#modifiable_groups") do
      with_tag("li.selected a.modifiable_group_link[href='#{pipelines_snippet_show_path(:group_name => 'foo')}']", 'foo')
      with_tag("a.modifiable_group_link[href='#{pipelines_snippet_show_path(:group_name => 'bar')}']", 'bar')
    end
  end
end
