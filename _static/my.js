$(document).ready(function() {
    // Remove the last updated
    $('p').last().detach();

    // Hide the search. CSS wouldn't do it...
    $('.navbar-form').hide();
    $('.navbar-toggle').detach();
    
    // Turn the first header section into a hero
    var first_section = $('.section').first();
    first_section.addClass('jumbotron');

    // Add a link to the PDF by abusing the Back to Top link
    var pdf_link = $('.footer .pull-right a');
    // Set the new text for the link
    pdf_link.empty();
    pdf_link.append($('<span class="glyphicon glyphicon-download-alt"/>'));
    pdf_link.append(' Download PDF');
    // Set the link and open in a new window
    pdf_link.attr('href', 'resume.pdf');
    pdf_link.attr('target', '_blank');

    // Make Employment section sexy
    $('#employment > ul').children('li').each(function (i_job, job) {
      job = $(job);
      // E.g. ( YYYY-YYYY ) | Job Title | Company
      var job_text_array = job.text().split('\n');
      var btn_name = '';
      var job_banner = [];
      $(job_text_array[0].split('|')).each(function (i_job_info, job_info) {
        switch ( i_job_info ) {
          // Years
          case 0:
            // Cleanup the parens
            job_info = job_info.replace(/[\(\)]/g, '');
            if ( i_job === 0 ) {
              // Highlight the current job
              btn_name = 'danger';
            } else {
              btn_name = 'primary';
            }
            break;
          // Job Title
          case 1:
            btn_name = 'default';
            break;
          // Company
          case 2:
            btn_name = 'success';
            break;
          default:
            btn_name = '';
            console.error('Unknown case. i: ' + i + ' job_info: ' + job_info);
        }
        // Now create the element and add it to the list
        btn = $('<span class="btn btn-sm btn-' + btn_name +'"/>');
        btn.text(job_info.trim());
        job_banner.push(btn);
      });
      // Get rid of the line we just turned into a header
      job.find('p.first').detach();
      // Create a new element to attach
      var pretty_job = $('<div/>');
      // Add the stylized job header info
      pretty_job.append($('<h2/>').append(job_banner));
      pretty_job.append($('<div class="well well-sm"/>').append(job.contents()));
      // Add to the section and remove li
      $('#employment').append(pretty_job);
      job.detach();
    });

});
