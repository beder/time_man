services = angular.module('services')

services.factory('report', [
  ->
    {
      build: (userName, date_from, date_to, activities)->
        "
        <html>
            <body>
                <h1>#{userName}'s activity report</h1>
                <h2>#{@period(date_from, date_to)}</h2>
                <ul>
                    #{@contents(activities)}
                </ul>
            </body>
        </html>
        "

      period: (date_from, date_to)->
        if @present(date_from) and @present(date_to)
          "From #{date_from} to #{date_to}"
        else if @present(date_from)
          "Since #{date_from}"
        else if @present(date_to)
          "Up to #{date_to}"
        else
          ''

      contents: (activities)->
        activities.reduce(
          (
            (report, a)->
              "
              #{report}
              <li>
                  #{a.name}
                  <ul>
                      <li>Date: #{a.date}</li>
                      <li>Hours: #{a.hours}</li>
                  </ul>
              </li>
              "
          ),
          ''
        )

      present: (value)->
          value? and value.length > 0
    }
])
