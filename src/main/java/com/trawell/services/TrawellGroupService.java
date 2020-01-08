package com.trawell.services;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Optional;
import com.trawell.models.TrawellGroup;
import com.trawell.repositories.GroupRepository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * @author Lamberti Vincenzo
 * @author Milione Vincent provides users of the class the ability to interact
 *         with the database and model users.
 */
@Service
public class TrawellGroupService implements ITrawellGroupService {

    @Autowired
    private GroupRepository groupRepository;

    @Override
    public Collection<TrawellGroup> findAll() {
        ArrayList<TrawellGroup> groups = new ArrayList<TrawellGroup>();
        groupRepository.findAll().forEach(groups::add);
        return groups;
    }

    @Override
    public TrawellGroup findOne(Long id) {
        Optional<TrawellGroup> trawellGroup = groupRepository.findById(id);
        return trawellGroup.get();
    }

    @Override
    public TrawellGroup create(TrawellGroup trawellGroup) {
        if (trawellGroup.getId() != null) {
            //cannot create User with specified Id value
            return null;
        }
        return groupRepository.save(trawellGroup);
    }

    @Override
    public TrawellGroup update(TrawellGroup trawellGroup) {
        if (trawellGroup.getId() == null) {
            //cannot create User with specified Id value
            return null;
        }
        return groupRepository.save(trawellGroup);
    }

    @Override
    public void delete(Long id) {
        

    }

    
}