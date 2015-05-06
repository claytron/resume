$(document).ready(function() {
    // Turn the first header section into a hero
    var first_section = $('.section').first();
    first_section.addClass('jumbotron');

    // XXX: No gravatar for now...
    // Move the image into a media tag
    //var profile_img = first_section.find('.gravatar-link').detach();
    //var container = $('<div class="row"/>');
    //container.append($('<div class="col-md-10"/>').append(first_section.contents()));
    //container.append($('<div class="col-md-2"/>').append(profile_img));
    //// Add the fancy version back
    //first_section.append(container);

    // Make Employment section sexy
    $('#employment > ul').children('li').each(function (i_job, job) {
      job = $(job);
      // E.g. ( YYYY-YYYY ) | Job | Company
      var job_text_array = job.text().split('\n');
      var job_banner = [];
      $(job_text_array[0].split('|')).each(function (i_job_str, job_str) {
        switch ( i_job_str ) {
          case 0:
            job_str = job_str.replace(/[\(\)]/g, '');
            if ( i_job === 0 ) {
              // Highlight the current job
              btn_name = 'danger';
            } else {
              btn_name = 'primary';
            }
            break;
          case 1:
            btn_name = 'default';
            break;
          case 2:
            if ( i_job == 4 ) {
              // Highlight the change of job
              btn_name = 'info';
            } else {
              btn_name = 'success';
            }
            break;
          default:
            btn_name = '';
            console.error('Unknown case. i: ' + i + ' job_str: ' + job_str);
        }
        btn = $('<span class="btn btn-sm btn-' + btn_name +'"/>');
        btn.text(job_str.trim());
        job_banner.push(btn);
      });
      // Get rid of the line we just turned into a header
      job.find('p.first').detach();
      // Create a new element to attach
      var pretty_job = $('<div/>');
      pretty_job.append($('<h2/>').append(job_banner));
      pretty_job.append($('<div class="well well-sm"/>').append(job.contents()));
      // Add to the section and remove li
      $('#employment').append(pretty_job);
      job.detach();
    });

});
