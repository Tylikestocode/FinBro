const apiSections = document.querySelectorAll('.api-section');

document.addEventListener('DOMContentLoaded', () => {
    const buttons = document.querySelectorAll('.api-button');
    const accordionButtons = document.querySelectorAll('.accordion-button');

    buttons.forEach(button => {
        button.addEventListener('click', function() {
            apiButtonClick(this);
        })
    });

    accordionButtons.forEach(button => {
        button.addEventListener('click', function() {
            showApiDetails(this);
        })
    });

    document.getElementById('users-api').style.display = 'block';

})


function apiButtonClick(button) {

    const buttons = document.querySelectorAll('.api-button');

    buttons.forEach(btn => btn.classList.remove('active'));

    button.classList.add('active')

}

function showSection(sectionId) {

    // Hide all sections
    apiSections.forEach(section => {
        section.style.display = 'none';
    });

    // Show the selected section
    const sectionToShow = document.getElementById(sectionId);
    sectionToShow.style.display = 'block';

}

function showApiDetails(button) {

    const content = button.nextElementSibling;

    console.log(content.nextElementSibling);

    if (content.style.display == 'block') {
        content.style.display = 'none';
    }
    else {
        content.style.display = 'block';
    }

}
